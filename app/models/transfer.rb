class Transfer < ApplicationRecord
  belongs_to :recipient, class_name: 'Storehouse', foreign_key: 'recipient_id'
  belongs_to :sender, class_name: 'Storehouse', foreign_key: 'sender_id'
  has_many :things, as: :shipment
  has_many :commodities, through: :things,  as: :shipment
  validates :things, presence: true
end
