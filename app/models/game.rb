class Game < ApplicationRecord
  belongs_to :user
  has_many :players, dependent: :destroy
  has_many :rounds, dependent: :destroy

  enum status: {
    created: 0,
    in_progress: 1,
    finished: 2
  }
end
