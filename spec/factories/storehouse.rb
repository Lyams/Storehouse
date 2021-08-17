FactoryBot.define do
  factory :storehouse do
    sequence(:title) {|n| "Storehouse ##{n}"}
    district {:central}
  end
end