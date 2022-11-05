class CreateExpenses < ActiveRecord::Migration[7.0]
  def change
    create_table :expenses do |t|
      t.references :expense_category, null: false, foreign_key: true
      t.date :date
      t.float :amount

      t.timestamps
    end
  end
end
