class AddDateOfDeliveryToDelivery < ActiveRecord::Migration[6.1]
  def change
    add_column :deliveries, :date_of_delivery, :date
  end
end
