class AddBalanceToUsers < ActiveRecord::Migration
  def change
    add_column :users, :balance, :decimal, DEFAULT 0, :precision => 8, :scale => 2
  end
end
