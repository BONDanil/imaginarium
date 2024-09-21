class Player < ApplicationRecord
  IMAGES_ON_HAND_COUNT = 6

  belongs_to :user
  belongs_to :game
  has_many :player_images
  has_many :images, through: :player_images

  def actualize_images
    if images.off_hand.any? && images.on_hand.count < IMAGES_ON_HAND_COUNT
      images.off_hand
            .first(IMAGES_ON_HAND_COUNT - images.on_hand.count)
            .update_all(status: :on_hand)
    end
  end

  def created_association_for_round?(round)
    round.associations.where(player: self).any?
  end
end
