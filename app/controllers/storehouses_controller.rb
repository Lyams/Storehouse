class StorehousesController < ApplicationController
  before_action :set_storehouse, only: %i[show update destroy]

  # GET /storehouses or /storehouses.json
  def index
    @storehouses = Storehouse.all
  end

  # GET /storehouses/1 or /storehouses/1.json
  def show
    @things = @storehouse.things
  end

  # GET /storehouses/new
  def new
    @storehouse = Storehouse.new
  end

  # POST /storehouses or /storehouses.json
  def create
    @storehouse = Storehouse.new(storehouse_params)

    respond_to do |format|
      if @storehouse.save
        format.html { redirect_to @storehouse, notice: 'Storehouse was successfully created.' }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    if @storehouse.things.blank?
      @storehouse.destroy
      respond_to do |format|
        format.html { redirect_to storehouses_url, notice: 'Storehouse was successfully destroyed.' }
      end
    else
      redirect_to @storehouse, notice: 'Склад нельзя удалять, если на нём есть товары'
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_storehouse
    @storehouse = Storehouse.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def storehouse_params
    params.require(:storehouse).permit(:title, :district)
  end
end
