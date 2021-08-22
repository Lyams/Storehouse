FactoryBot.define do
  factory :thing do
    association :commodity
    value { 5 }
    shipment { build(:storehouse) }
  end
end