class CreateThings < ActiveRecord::Migration[6.1]
  def change
    create_table :things do |t|
      t.integer :value
      t.references :commodity, null: false, foreign_key: true
      t.references :storehouse, null: false, foreign_key: true

      t.timestamps
    end
  end
end
