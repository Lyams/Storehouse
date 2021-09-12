class DeliveriesController < ApplicationController
  include DeliverySaver

  def new
    if Commodity.take.blank?
      redirect_to commodities_path, notice: (t 'commodity.has_not')
    else
      @storehouse = Storehouse.find(params[:storehouse_id])
      @delivery = Delivery.new
      @things = Commodity.all.map do |com|
        thing = Thing.new
        thing.commodity_id = com.id
        thing.value = 0
        thing
      end
      @delivery.things = @things
    end
  end

  def create
    @delivery = Delivery.new(delivery_params)
    @storehouse = @delivery.storehouse
    if delivery_transaction(things_params: things_params, storehouse: @storehouse, delivery: @delivery)
      redirect_to @delivery.storehouse, notice: (I18n.t 'delivery.success_created')
    else
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
