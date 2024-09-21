class Association < ApplicationRecord
  belongs_to :player
  belongs_to :round
  has_one :image

  after_create :sync_round_status!

  private

  def sync_round_status!
    round.sync_status!
  end
end
