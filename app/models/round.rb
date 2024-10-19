class Round < ApplicationRecord
  belongs_to :game
  belongs_to :host, class_name: "Player"
  has_many :associations, dependent: :destroy

  after_update :sync_game_status!, if: :finished?

  enum status: {
    host_choice: 0,
    players_choice: 1,
    finished: 2
  }

  scope :unfinished, -> { where.not(status: :finished) }
  scope :ordered, -> { order(:created_at) }

  def sync_status!
    players_choice! if host_association.present?
    finished! if game.players.count == associations.count
  end

  def sync_game_status!
    game.sync_status!
  end

  def host_association
    associations.find_by(player: host)
  end
end
