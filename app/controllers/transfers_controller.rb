class TransfersController < ApplicationController
  def new
    @sender = Storehouse.find(storehouses_params[:sender_id])
    @recipient = Storehouse.find(storehouses_params[:recipient_id])
    @transfer = Transfer.new(sender: @sender, recipient: @recipient)
    @commodities = Commodity.all
    @things = @sender.things
  end
  def create
    @transfer = Transfer.new(transfer_params)
    @transfer.save
    @sender = @transfer.sender
    @recipient = @transfer.recipient
    @things = things_params[:thing].each do |param|
      thing = Thing.new(param[1])
      if thing.value.present? && thing.value > 0
        was_sender_thing = @sender.things.where(commodity_id: thing.commodity_id).first
        thing.value = was_sender_thing.value if thing.value > was_sender_thing.value
        thing.shipment = @transfer
        diff = was_sender_thing.value - thing.value
        diff > 0 ? was_sender_thing.update(value: diff ) : was_sender_thing.destroy
        was_recipient_thing = @recipient.things.where(commodity_id: thing.commodity_id).first
        was_recipient_thing = Thing.new(shipment: @recipient, value: 0, commodity_id: thing.commodity_id) if was_recipient_thing.nil?
        was_recipient_thing.update(value: (was_recipient_thing.value + thing.value) )
        end
      end
    respond_to do |format|
      if true # @delivery.save
        format.html { redirect_to @recipient, notice: 'Transaction was successfully created.' }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
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
