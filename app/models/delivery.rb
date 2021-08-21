class Delivery < ApplicationRecord
  has_many :things, as: :shipment
  belongs_to :storehouse
  has_many :commodities, through: :things,  as: :shipment
  validates :date_of_delivery, presence: true
end