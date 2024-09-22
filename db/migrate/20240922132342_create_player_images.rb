class CreatePlayerImages < ActiveRecord::Migration[7.1]
  def change
    create_table :player_images do |t|
      t.references :player, null: false, foreign_key: true
      t.references :image, null: false, foreign_key: true
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
