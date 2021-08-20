class Storehouse < ApplicationRecord
  extend Enumerize
  # By default, enumerize adds inclusion validation to the model.
  # You can skip validations by passing skip_validations option.
  enumerize :district, in: [ :central, :northwestern, :southern, :north_caucasian, :volga, :ural, :siberian, :far_eastern]
  validates :title, presence: true, length: { minimum: 2 }, uniqueness: { case_sensitive: false }
  has_many :things, as: :shipment
  has_many :commodities, through: :things,  as: :shipment
  has_many :deliveries,  dependent: :destroy
  has_many :sender_transfers, class_name: 'Transfer', foreign_key: :sender_id,  dependent: :destroy
  has_many :senders, through: :sender_transfers, source: :sender
  has_many :recipient_transfers, class_name: 'Transfer', foreign_key: :recipient_id,  dependent: :destroy
  has_many :recipients, through: :recipient_transfers, source: :recipient
end