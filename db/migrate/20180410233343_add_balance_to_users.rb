class AddBalanceToUsers < ActiveRecord::Migration
  def change
    add_column :users, :balance, :decimal, 0, :precision => 8, :scale => 2
  end
end
