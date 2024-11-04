class Association < ApplicationRecord
  # TODO: add column host:boolean, and use of_host? method

  belongs_to :player
  belongs_to :round
  belongs_to :image
  has_many :votes, dependent: :destroy

  after_create :sync_round_status!
  after_create :sync_image_status!

  scope :by_player, ->(player) { where(player:) }

  private

  def sync_round_status!
    round.sync_status!
  end

  def sync_image_status!
    player.player_images.find_by(image:).played!
  end
end
