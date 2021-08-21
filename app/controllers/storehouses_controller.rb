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
        format.json { render :show, status: :created, location: @storehouse }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @storehouse.errors, status: :unprocessable_entity }
      end
    end
  end

  # # PATCH/PUT /storehouses/1 or /storehouses/1.json
  # def update
  #   respond_to do |format|
  #     if @storehouse.update(storehouse_params)
  #       format.html { redirect_to @storehouse, notice: "Storehouse was successfully updated." }
  #       format.json { render :show, status: :ok, location: @storehouse }
  #     else
  #       format.html { render :edit, status: :unprocessable_entity }
  #       format.json { render json: @storehouse.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # DELETE /storehouses/1 or /storehouses/1.json
  def destroy
    if @storehouse.things.blank?
    @storehouse.destroy
    respond_to do |format|
      format.html { redirect_to storehouses_url, notice: 'Storehouse was successfully destroyed.' }
      format.json { head :no_content }
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
