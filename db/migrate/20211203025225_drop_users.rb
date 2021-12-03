class DropUsers < ActiveRecord::Migration[6.1]
  def up
    drop_table :users
  end
end
