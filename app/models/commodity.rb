class Commodity < ApplicationRecord
  validates :name, presence: true, length: { minimum: 2 }, uniqueness: { case_sensitive: false }
  has_many :things
  has_many :storehouses, through: :things, source: :shipment, source_type: "Storehouse"
  has_many :deliveries, through: :things, source: :shipment, source_type: "Delivery"
  has_many :transfers, through: :things, source: :shipment, source_type: "Transfer"
end
