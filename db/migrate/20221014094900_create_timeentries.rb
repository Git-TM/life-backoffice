class CreateTimeentries < ActiveRecord::Migration[7.0]
  def change
    create_table :timeentries do |t|
      t.string :name
      t.string :tag
      t.string :description
      t.datetime :start_date
      t.datetime :end_date
      t.references :categorytime, null: false, foreign_key: true

      t.timestamps
    end
  end
end
