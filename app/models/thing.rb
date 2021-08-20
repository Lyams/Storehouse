class Thing < ApplicationRecord
  belongs_to :commodity
  belongs_to :shipment, polymorphic: true
  validates :value, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1 }
  validates :commodity, presence: true
end
