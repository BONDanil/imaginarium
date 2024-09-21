class AddHostIdsOrderToGames < ActiveRecord::Migration[7.1]
  def change
    add_column :games, :host_ids_order, :string, default: "[]"
  end
end
