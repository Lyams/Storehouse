class Delivery < ApplicationRecord
  has_many :things, as: :shipment
  has_one :storehouse
end