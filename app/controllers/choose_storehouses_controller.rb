class ChooseStorehousesController < ApplicationController
  def new
    @storehouses = Storehouse.all# url: new_transfer_url, method: :get
    @transfer = Transfer.new
  end
  def create
    @sender = Storehouse.find(storehouses_params[:sender_id])
    @recipient = Storehouse.find(storehouses_params[:recipient_id])
    if @sender == @recipient
      @transfer = Transfer.new
      @storehouses = Storehouse.all
      render :new, status: :unprocessable_entity, notice: 'Должны быть разные склады'
      else
      redirect_to new_transfer_path(sender_id: @sender.id, recipient_id: @recipient.id)
    end
  end

  private

  def storehouses_params
    params.permit(:recipient_id, :sender_id)
  end
end