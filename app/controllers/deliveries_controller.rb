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
    @delivery.save
    @storehouse = @delivery.storehouse
    @things = things_params[:thing].each do |param|
      p "Отладочное сообщение #{param}"
      thing = Thing.new(param[1])
      # thing.commodity_id = param[:commodity_id].to_i
      # val = param[:value].to_i
      if  thing.value.present? && thing.value > 0
        thing.shipment = @delivery
        t = Thing.new(commodity_id: thing.commodity_id, value: thing.value, shipment: @storehouse)
        thing.save
        if ist = Thing.where(commodity_id: thing.commodity_id, shipment_id: @storehouse.id, shipment_type: 'Storehouse').first
          ist.update( value: (ist.value + thing.value))
        else
          t.save
        end
      end
    end
    respond_to do |format|
      if true # @delivery.save
        format.html { redirect_to @delivery.storehouse, notice: 'Delivery was successfully created.' }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def index
    @storehouse = Storehouse.find(params[:storehouse_id])
    @deliveries = @storehouse.deliveries
  end

  private

  def delivery_params
    params.require(:delivery).permit(:storehouse_id)
  end
  def things_params
    params.require(:delivery).permit(thing: [:commodity_id, :value])
  end

end