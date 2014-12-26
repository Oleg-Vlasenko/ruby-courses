FactoryGirl.define do
  factory :order_item do
    price 1.5
    quantity 1
    total_sum 1
    book nil
    order nil
  end

end
