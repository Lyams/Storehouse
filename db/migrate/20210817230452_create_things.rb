class CreateThings < ActiveRecord::Migration[6.1]
  def change
    create_table :things do |t|
      t.integer :value, null: false
      t.references :commodity, null: false, foreign_key: true
      t.references :shipment, polymorphic: true, null: false

      t.timestamps
    end
  end
end
