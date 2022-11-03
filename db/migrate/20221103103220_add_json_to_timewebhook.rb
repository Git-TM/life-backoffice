class AddJsonToTimewebhook < ActiveRecord::Migration[7.0]
  def change
    add_column :timewebhooks, :event_data, :jsonb, null: false, default: {}
  end
end
