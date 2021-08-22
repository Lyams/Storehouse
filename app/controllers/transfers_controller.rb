class TransfersController < ApplicationController

  def index
    @storehouse = Storehouse.find(params[:storehouse_id])
    @transfers_send = Transfer.where(sender: @storehouse)
    @transfers_recip = Transfer.where(recipient: @storehouse)
  end

  def new
    @sender = Storehouse.find(storehouses_params[:sender_id])
    @recipient = Storehouse.find(storehouses_params[:recipient_id])
    @transfer = Transfer.new(sender: @sender, recipient: @recipient)
    @commodities = Commodity.all
    @things = @sender.things
  end

  def create
    @transfer = Transfer.new(transfer_params)
    @sender = @transfer.sender
    @recipient = @transfer.recipient
    if helpers.transfer_transaction(things_params: things_params, sender: @sender,
                                    transfer: @transfer, recipient: @recipient)
      redirect_to @recipient, notice: (I18n.t 'transfer.success_created')
    else
      redirect_to new_transfer_path(sender_id:  @sender.id, recipient_id: @recipient.id),
                  notice: (I18n.t 'transfer.failed_created')
    end
  end

  private

  def storehouses_params
    params.permit(:recipient_id, :sender_id)
  end

  def transfer_params
    params.require(:transfer).permit(:recipient_id, :sender_id)
  end

  def things_params
    params.require(:transfer).permit(thing: [:commodity_id, :value])
  end
end
