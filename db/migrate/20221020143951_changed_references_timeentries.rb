class ChangedReferencesTimeentries < ActiveRecord::Migration[7.0]
  def change
    remove_reference :timeentries, :categorytime, index: true, foreign_key: true
    add_reference :timeentries, :timesubcategory, index: true, foreign_key: true
  end
end
