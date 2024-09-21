class Association < ApplicationRecord
  belongs_to :player
  belongs_to :round
  has_one :image
end
