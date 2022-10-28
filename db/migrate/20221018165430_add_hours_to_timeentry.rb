class AddHoursToTimeentry < ActiveRecord::Migration[7.0]
  def change
    add_column :timeentries, :durationinhour, :float
  end
end
