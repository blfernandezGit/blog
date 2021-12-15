class CreateCashes < ActiveRecord::Migration[6.1]
  def change
    create_table :cashes do |t|
      t.decimal :balance
      t.decimal :last_cash_in_amt
      t.belongs_to :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
