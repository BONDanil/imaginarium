class CreateImages < ActiveRecord::Migration[7.1]
  def change
    create_table :images do |t|
      t.references :pack, null: false, foreign_key: { to_table: :image_packs }

      t.timestamps
    end
  end
end
