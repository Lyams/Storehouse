class CreateCommodities < ActiveRecord::Migration[6.1]
  def change
    create_table :commodities do |t|
      t.string :name, null: false

      t.timestamps
    end
  end
end
