class Association < ApplicationRecord
  # TODO: validate presence of description, if its host's association

  belongs_to :player
  belongs_to :round
  belongs_to :image

  after_create :sync_round_status!
  after_create :sync_image_status!

  private

  def sync_round_status!
    round.sync_status!
  end

  def sync_image_status!
    player.player_images.find_by(image:).played!
  end
end
