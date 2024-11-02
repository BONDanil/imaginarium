class ImagePack < ApplicationRecord
  has_many :images, foreign_key: "pack_id", dependent: :destroy
  has_many :games, dependent: :nullify
end
