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
    Transfer.transaction do
      @things = []
        things_params[:thing].each do |param|
        thing = Thing.new(param[1])
        if thing.value.present? && thing.value > 0
          was_sender_thing = @sender.things.where(commodity_id: thing.commodity_id).first
          thing.value = was_sender_thing.value if thing.value > was_sender_thing.value
          thing.shipment = @transfer
          diff = was_sender_thing.value - thing.value
          diff > 0 ? was_sender_thing.update(value: diff) : was_sender_thing.destroy
          was_recipient_thing = @recipient.things.where(commodity_id: thing.commodity_id).first
          was_recipient_thing = Thing.new(shipment: @recipient, value: 0, commodity_id: thing.commodity_id) if was_recipient_thing.nil?
          was_recipient_thing.update(value: (was_recipient_thing.value + thing.value))
          thing.save
          @things = thing
        end
      end
      if @things.present?
        @transfer.save
        redirect_to @recipient, notice: 'Transaction was successfully created.'
      else
        redirect_to new_transfer_path(sender_id:  @sender.id, recipient_id: @recipient.id),
                    notice: 'Неверно заполненные поля'
      end
    rescue ActiveRecord::RecordInvalid
      redirect_to new_transfer_path(sender_id:  @sender.id, recipient_id: @recipient.id),
                  notice: 'Что-то пошло не так, попробуйте ещё раз'
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
