class CreateImagePacks < ActiveRecord::Migration[7.1]
  def change
    create_table :image_packs do |t|
      t.string :name

      t.timestamps
    end
  end
end
