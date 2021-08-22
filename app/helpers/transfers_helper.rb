module TransfersHelper
  def transfer_transaction(things_params:, sender:, transfer:, recipient:)
    Transfer.transaction do
      @things = []
      things_params[:thing].each do |param|
        thing = Thing.new(param[1])
        if thing.value.present? && thing.value > 0
          was_sender_thing = sender.things.where(commodity_id: thing.commodity_id).first
          thing.value = was_sender_thing.value if thing.value > was_sender_thing.value
          thing.shipment = transfer
          diff = was_sender_thing.value - thing.value
          diff > 0 ? was_sender_thing.update(value: diff) : was_sender_thing.destroy
          was_recipient_thing = recipient.things.where(commodity_id: thing.commodity_id).first
          was_recipient_thing = Thing.new(shipment: recipient, value: 0, commodity_id: thing.commodity_id) if was_recipient_thing.nil?
          was_recipient_thing.update(value: (was_recipient_thing.value + thing.value))
          thing.save
          @things << thing
        end
      end
      if @things.present?
        transfer.save
        true
      else
        raise ActiveRecord::RecordInvalid
      end
    rescue ActiveRecord::RecordInvalid
      false
    end
  end
end
