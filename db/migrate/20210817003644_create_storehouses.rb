class CreateStorehouses < ActiveRecord::Migration[6.1]
  def change
    create_table :storehouses do |t|
      t.string :title, null: false
      t.string :district, null: false

      t.timestamps
    end
  end
end
