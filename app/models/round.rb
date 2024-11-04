class Round < ApplicationRecord
  belongs_to :game
  belongs_to :host, class_name: "Player"
  has_many :associations, dependent: :destroy
  has_many :votes, through: :associations

  after_update :sync_game_status!, if: :finished?

  enum status: {
    host_choice: 0,
    players_choice: 1,
    guessing: 2,
    finished: 3
  }

  scope :unfinished, -> { where.not(status: :finished) }
  scope :ordered, -> { order(:created_at) }

  def sync_status!
    if host_association.present? && host_choice?
      players_choice!
    elsif game.players.count == associations.count && players_choice?
      guessing!
    elsif guessing? && votes.count == game.players.count - 1
      ::Rounds::Finish.new(self).call
    end
  end

  def sync_game_status!
    game.sync_status!
  end

  def host_association
    associations.find_by(player: host)
  end
end
