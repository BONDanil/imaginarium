class Game < ApplicationRecord
  belongs_to :user
  has_many :players, dependent: :destroy
  has_many :rounds, dependent: :destroy

  serialize :host_ids_order, coder: JSON

  enum status: {
    created: 0,
    in_progress: 1,
    finished: 2
  }

  def current_host
    player_id = host_ids_order[(rounds.count + 1) % host_ids_order.count]
    players.find(player_id)
  end
end
