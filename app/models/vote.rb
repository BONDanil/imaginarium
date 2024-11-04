class Vote < ApplicationRecord
  # TODO: avoid  self voiting

  belongs_to :game_association, class_name: "Association", foreign_key: :association_id
  belongs_to :player
  has_one :round, through: :game_association

  after_create :sync_round_status!

  private

  def sync_round_status!
    game_association.round.sync_status!
  end
end
