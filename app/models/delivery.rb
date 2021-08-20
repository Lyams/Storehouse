class Delivery < ApplicationRecord
  has_many :things, as: :shipment
  belongs_to :storehouse
  #before_validation :erase_empty_things

  def erase_empty_things
    things = self.things
    self.things = things.select { |thing| thing.value > 0 }
  end
end