class CreateCommodities < ActiveRecord::Migration[6.1]
  def change
    create_table :commodities do |t|
      t.string :name

      t.timestamps
    end
  end
end
