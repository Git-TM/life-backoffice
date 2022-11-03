class CreateTimewebhooks < ActiveRecord::Migration[7.0]
  def change
    create_table :timewebhooks do |t|
      t.boolean :processed

      t.timestamps
    end
  end
end
