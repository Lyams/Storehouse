FactoryBot.define do
  factory :commodity do
    name {Faker::Commerce.product_name}
  end
end