class AddImageReferencesToAssociations < ActiveRecord::Migration[7.1]
  def change
    add_reference :associations, :image, index: true
  end
end
