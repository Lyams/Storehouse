module DeliveriesHelper
  def delivery_transaction(things_params:, storehouse:, delivery:)
    Delivery.transaction do
      @things = []
      things_params[:thing].each do |param|
        thing = Thing.new(param[1])
        if thing.value.present? && thing.value.positive?
          thing.shipment = delivery
          in_st = Thing.find_by(commodity_id: thing.commodity_id, shipment_id: storehouse.id, shipment_type: 'Storehouse')
          if in_st.present?
            in_st.update(value: (in_st.value + thing.value))
          else
            to_store = Thing.new(commodity_id: thing.commodity_id, value: thing.value, shipment: storehouse)
            to_store.save
          end
          thing.save
          @things << thing
        end
      end
      if @things.present?
        delivery.save
      else
        raise ActiveRecord::RecordInvalid
      end
    rescue ActiveRecord::RecordInvalid
      false
    end
  end
end
