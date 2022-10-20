class RemovereferencesToCategorytime < ActiveRecord::Migration[7.0]
  def change
    remove_reference :timeentries, :categorytime, index: true, foreign_key: true
    remove_reference :timesubcategories, :categorytime, index: true, foreign_key: true
  end
end
