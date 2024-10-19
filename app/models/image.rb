class Image < ApplicationRecord
  belongs_to :pack, class_name: "ImagePack"
  has_one_attached :img
  has_many :player_images
  has_many :players, through: :player_images
  has_many :associations, dependent: :destroy
end
