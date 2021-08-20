class CreateDeliveries < ActiveRecord::Migration[6.1]
  def change
    create_table :deliveries do |t|
      t.references :storehouse, null: false, foreign_key: true
      t.timestamps
    end
  end
end
