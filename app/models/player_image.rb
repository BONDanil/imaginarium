class PlayerImage < ApplicationRecord
  belongs_to :player
  belongs_to :image

  enum status: {
    on_hand: 0,
    off_hand: 1,
    played: 2
  }
end
