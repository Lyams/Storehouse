class CreateTransfers < ActiveRecord::Migration[6.1]
  def change
    create_table :transfers do |t|
      t.references :sender, foreign_key: {to_table: :storehouses, column: :recipient_id}
      t.references :recipient, foreign_key: {to_table: :storehouses, column: :sender_id}
      t.timestamps
    end
  end
end
