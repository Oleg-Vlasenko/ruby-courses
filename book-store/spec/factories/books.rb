# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :book do
    sequence(:title) {Faker::Lorem.sentence(2)}
    description Faker::Lorem.sentence(4)
    sequence(:price) {Random.rand(1.5..20)}
    sequence(:stock) {Random.rand(1..10)}
    association :author, factory: :author
    association :category, factory: :category
  end
end
