class CommoditiesController < ApplicationController
  before_action :set_commodity, only: %i[show update edit destroy]

  def index
    @commodities = Commodity.all
  end

  def new
    @commodity = Commodity.new
  end

  def show; end

  def edit; end

  def create
    @commodity = Commodity.new(commodity_params)

    respond_to do |format|
      if @commodity.save
        format.html { redirect_to @commodity, notice: 'Commodity was successfully created.' }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @commodity.update(commodity_params)
        format.html { redirect_to @commodity, notice: 'Commodity was successfully updated.' }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end


  def destroy
    if @commodity.deliveries.present? || @commodity.transfers.present? || @commodity.storehouses.present?
      redirect_back fallback_location: storehouses_path,
                    notice:  'Нельзя удалить товар с наличием  на складах или историей доставок или историей передач'
    else
    @commodity.destroy
    respond_to do |format|
      format.html { redirect_to commodities_path, notice: 'Commodity was successfully destroyed.' }
      format.json { head :no_content }
    end
    end
  end

  private

  def set_commodity
    @commodity = Commodity.find(params[:id])
  end

  def commodity_params
    params.require(:commodity).permit(:name)
  end
end
