class Commodity < ApplicationRecord
  validates :name, presence: true, length: { minimum: 2 }, uniqueness: { case_sensitive: false }
end
