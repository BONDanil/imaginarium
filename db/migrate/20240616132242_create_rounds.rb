class CreateRounds < ActiveRecord::Migration[7.1]
  def change
    create_table :rounds do |t|
      t.references :game, null: false, foreign_key: true
      t.references :host, null: false, foreign_key: { to_table: :players }
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
