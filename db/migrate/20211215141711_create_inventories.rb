class CreateInventories < ActiveRecord::Migration[6.1]
  def change
    create_table :inventories do |t|
      t.string :stock_code
      t.string :stock_name
      t.integer :quantity
      t.belongs_to :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
