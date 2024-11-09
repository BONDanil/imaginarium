class Player < ApplicationRecord
  IMAGES_ON_HAND_COUNT = 6

  belongs_to :user
  belongs_to :game
  has_many :player_images, dependent: :destroy
  has_many :images, through: :player_images
  has_many :votes, dependent: :destroy

  delegate :nickname, to: :user, prefix: false

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

  def voted_in_round?(round)
    round.votes.where(player: self).any?
  end

  def images_on_hand
    images.joins(:player_images).where(player_images: { status: 'on_hand' }).distinct
  end
end
