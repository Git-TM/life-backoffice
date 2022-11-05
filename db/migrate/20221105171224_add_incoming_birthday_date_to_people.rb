class AddIncomingBirthdayDateToPeople < ActiveRecord::Migration[7.0]
  def change
    add_column :people, :incomingbirthday, :datetime
  end
end
