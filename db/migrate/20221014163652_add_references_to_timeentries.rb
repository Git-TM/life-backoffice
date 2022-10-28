class AddReferencesToTimeentries < ActiveRecord::Migration[7.0]
  def change
    add_reference :timeentries, :user, index: true, foreign_key: true
  end
end
