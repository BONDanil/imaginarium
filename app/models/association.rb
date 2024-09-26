class Association < ApplicationRecord
  # TODO: validate presence of description, if its host's association

  belongs_to :player
  belongs_to :round
  has_one :image

  after_create :sync_round_status!

  private

  def sync_round_status!
    round.sync_status!
  end
end
