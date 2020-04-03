class CreateBalanceTransfers < ActiveRecord::Migration[6.0]
  def change
    create_table :balance_transfers do |t|
      t.integer :amount
      t.references :account

      t.timestamps
    end
  end
end
