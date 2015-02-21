class CreateTransfers < ActiveRecord::Migration
  def change
    create_table :transfers do |t|
      t.integer :sender_id
      t.integer :reciever_id
      t.integer :amount

      t.timestamps null: false
    end
    add_foreign_key :users, column: :sender_id
    add_foreign_key :users, column: :reciever_id
  end
end
