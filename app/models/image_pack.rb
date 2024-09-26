class ImagePack < ApplicationRecord
  has_many :images, foreign_key: "pack_id"
  has_many :games
end
