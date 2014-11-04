# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :rating do
    sequence(:title) {Faker::Lorem.sentence(2)}
    review Faker::Lorem.sentence(4)
    sequence(:rating_number) {Random.rand(1..5)}
    association :book, factory: :book
    association :customer, factory: :customer
  end
end
