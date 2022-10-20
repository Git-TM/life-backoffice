class AddReferencesToCategorytime < ActiveRecord::Migration[7.0]
  def change
    add_reference :timeentries, :categorytime, index: true, foreign_key: true
    add_reference :timesubcategories, :categorytime, index: true, foreign_key: true
  end
end
