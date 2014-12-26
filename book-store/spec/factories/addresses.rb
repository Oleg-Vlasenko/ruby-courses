# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :address do
    address Faker::Address.street_address
    zip_code Faker::Address.zip_code
    city Faker::Address.city
    phone Faker::PhoneNumber.phone_number
    country nil
  end
end
