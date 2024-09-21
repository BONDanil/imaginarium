class Round < ApplicationRecord
  belongs_to :game
  belongs_to :host, class_name: "Player"
  has_many :associations, dependent: :destroy

  enum status: {
    host_choice: 0,
    players_choice: 1,
    finished: 2
  }

  scope :unfinished, -> { where.not(status: :finished) }
  scope :ordered, -> { order(:created_at) }

  def sync_status!
    finished! if game.players.count == associations.count
  end
end
