class ImagePack < ApplicationRecord
  has_many :images
  has_many :games
end
