class CreatePeople < ActiveRecord::Migration[7.0]
  def change
    create_table :people do |t|
      t.string :firstname
      t.string :lastname
      t.date :dob
      t.references :peopletype, null: false, foreign_key: true

      t.timestamps
    end
  end
end
