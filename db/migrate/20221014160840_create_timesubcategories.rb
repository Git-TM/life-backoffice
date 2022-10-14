class CreateTimesubcategories < ActiveRecord::Migration[7.0]
  def change
    create_table :timesubcategories do |t|
      t.string :name
      t.boolean :shortweek
      t.references :categorytime, null: false, foreign_key: true

      t.timestamps
    end
  end
end
