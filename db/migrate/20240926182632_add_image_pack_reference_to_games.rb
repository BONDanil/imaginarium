class AddImagePackReferenceToGames < ActiveRecord::Migration[7.1]
  def change
    add_reference :games, :image_pack, foreign_key: true
  end
end
