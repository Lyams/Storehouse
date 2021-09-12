module TransferSaver
  def transfer_transaction(things_params:, sender:, transfer:, recipient:)
    Transfer.transaction do
      @things = []
      things_params[:thing].map { |el| Thing.new(el[1])}.filter{ |el| el.value.present? && el.value > 0} do |thing|
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
      if @things.present?
        transfer.save
      else
        raise ActiveRecord::RecordInvalid
      end
    rescue ActiveRecord::RecordInvalid
      false
    end
  end
  protected
  def receipt_of_cargo
  end

  def dispatch_of_cargo
  end
end