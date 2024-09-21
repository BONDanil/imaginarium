class AddRoundReferencesToAssociations < ActiveRecord::Migration[7.1]
  def change
    add_reference :associations, :round, foreign_key: true
  end
end
