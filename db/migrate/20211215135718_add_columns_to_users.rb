class AddColumnsToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :full_name, :string
    add_column :users, :role, :string
    add_column :users, :status, :string
  end
end
