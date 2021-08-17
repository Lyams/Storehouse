class CreateStorehouses < ActiveRecord::Migration[6.1]
  def change
    create_table :storehouses do |t|
      t.string :title
      t.string :district

      t.timestamps
    end
  end
end
