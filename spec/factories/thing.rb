FactoryBot.define do
  factory :thing do
    association :commodity
    association :storehouse
    value { 5 }
  end
end