class Storehouse < ApplicationRecord
  extend Enumerize
  # By default, enumerize adds inclusion validation to the model.
  # You can skip validations by passing skip_validations option. warning
  enumerize :district, in: [ :central, :northwestern, :southern, :north_caucasian, :volga, :ural, :siberian, :far_eastern]
  validates :title, presence: true, length: { minimum: 2 }, uniqueness: { case_sensitive: false }
  has_many :things
end
