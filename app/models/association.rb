class Association < ApplicationRecord
  belongs_to :player
  has_one :image
end
