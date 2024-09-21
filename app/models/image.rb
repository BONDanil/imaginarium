class Image < ApplicationRecord
  has_one_attached :img
  has_many :player_images
  has_many :players, through: :player_images
end
