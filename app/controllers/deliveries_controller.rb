class DeliveriesController < ApplicationController

  def new
    @storehouse = Storehouse.find(params[:storehouse_id])
    @delivery = Delivery.new
    @things = Commodity.all.map do |com|
      thing = Thing.new
      thing.commodity_id = com.id
      thing.value = 0
      #thing.shipment = @delivery
      thing
    end
    @delivery.things = @things
  end

  def create
    @delivery = Delivery.new(delivery_params)
    @storehouse = @delivery.storehouse
    @things = []
    Delivery.transaction do
      things_params[:thing].each do |param|
        thing = Thing.new(param[1])
        if thing.value.present? && thing.value > 0
          thing.shipment = @delivery
          in_st = Thing.find_by(commodity_id: thing.commodity_id, shipment_id: @storehouse.id, shipment_type: 'Storehouse')
          if in_st.present?
            in_st.update(value: (in_st.value + thing.value))
          else
            to_store = Thing.new(commodity_id: thing.commodity_id, value: thing.value, shipment: @storehouse)
            to_store.save
          end
          thing.save
          @things = thing
        end
      end
      if @things.present?
        @delivery.save
        redirect_to @delivery.storehouse, notice: 'Delivery was successfully created.'
      else
        redirect_to new_storehouse_delivery_path(@storehouse)
      end
    rescue ActiveRecord::RecordInvalid
      redirect_to new_storehouse_delivery_path(@storehouse)
    end
  end

  def index
    @storehouse = Storehouse.find(params[:storehouse_id])
    @deliveries = @storehouse.deliveries
  end

  private

  def delivery_params
    params.require(:delivery).permit(:storehouse_id, :date_of_delivery)
  end

  def things_params
    params.require(:delivery).permit(thing: [:commodity_id, :value])
  end

end