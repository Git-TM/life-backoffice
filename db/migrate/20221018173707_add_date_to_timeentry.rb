class AddDateToTimeentry < ActiveRecord::Migration[7.0]
  def change
    add_column :timeentries, :date, :datetime
  end
end
