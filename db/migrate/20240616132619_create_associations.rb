class CreateAssociations < ActiveRecord::Migration[7.1]
  def change
    create_table :associations do |t|
      t.references :player, null: false, foreign_key: true
      t.string :description

      t.timestamps
    end
  end
end
