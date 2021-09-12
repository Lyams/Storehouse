class ChooseStorehousesController < ApplicationController
  def new
    if Commodity.take.blank?
      redirect_to commodities_path, notice: (t 'commodity.has_not')
    else
      @storehouses = Storehouse.all
      @transfer = Transfer.new
    end
  end

  def create
    @sender = Storehouse.find(storehouses_params[:sender_id])
    @recipient = Storehouse.find(storehouses_params[:recipient_id])
    if @sender == @recipient
      @transfer = Transfer.new
      @storehouses = Storehouse.all
      render :new, status: :unprocessable_entity, notice: (I18n.t 'transfer.identical_storehouse')
    else
      redirect_to new_transfer_path(sender_id: @sender.id, recipient_id: @recipient.id)
    end
  end

  private

  def storehouses_params
    params.permit(:recipient_id, :sender_id)
  end
end