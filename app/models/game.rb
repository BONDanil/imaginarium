class Game < ApplicationRecord
  belongs_to :user
  has_many :players, dependent: :destroy
  has_many :rounds, dependent: :destroy
  belongs_to :image_pack, optional: true # TODO: remove optional

  serialize :host_ids_order, coder: JSON

  enum status: {
    created: 0,
    in_progress: 1,
    finished: 2
  }

  delegate :status, to: :current_round, prefix: true
  delegate :players_with_associations, to: :current_round, prefix: false
  delegate :players_with_votes, to: :current_round, prefix: false

  def next_host
    player_id = host_ids_order[(rounds.count) % host_ids_order.count]
    players.find(player_id)
  end

  def current_host
    return default_host if created?

    current_round.host
  end

  def default_host
    @default_host ||= players.find_by(user: self.user)
  end

  def shuffled_players
    @shuffled_players ||= players.shuffle
  end

  def distribute_images!
    available_images = image_pack.images
    images_count_per_player = available_images.count / players.count
    game_images = available_images.sample(images_count_per_player * players.count)
    game_images.each_slice(images_count_per_player).with_index do |images, index|
      shuffled_players[index].images << images
    end
  end

  def valid_user?(user)
    players.pluck(:user_id).include?(user.id)
  end

  def valid_player?(player)
    player_ids.include?(player.id)
  end

  def player_role(player)
    return unless valid_player?(player)

    current_host == player ? :host : :player
  end

  def current_round
    rounds.last
  end

  def player_by_user(user)
    players.find_by(user:)
  end

  def create_next_round!
    return if rounds.unfinished.any?

    rounds.create(host: next_host)
  end

  def sync_status!
    finished! if rounds.count == players.count
  end

  def players_without_host
    players.excluding(current_host)
  end
end
