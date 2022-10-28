class CreatePeopletypes < ActiveRecord::Migration[7.0]
  def change
    create_table :peopletypes do |t|
      t.string :name

      t.timestamps
    end
  end
end
