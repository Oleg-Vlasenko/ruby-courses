# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'faker'

authors = []
10.times do
  authors << Author.create(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, biography: Faker::Lorem.sentence(3))
end

customers = []
10.times do
  customers << Customer.create(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, email: Faker::Internet.email, password_digest: Faker::Lorem.characters(10))
end

category = []
category << Category.create(title: 'Non-fiction')
category << Category.create(title: 'Science fiction')
category << Category.create(title: 'Romance')
category << Category.create(title: 'History')
category << Category.create(title: 'Guide')

74.times do
  book = Book.create(author: authors[Random.rand(0..9)], category: category[Random.rand(0..4)], title: Faker::Lorem.sentence(2).chop, description: Faker::Lorem.paragraph(10), price: Random.rand(5..20), stock: Random.rand(1..9))
  Random.rand(0..4).times do
    Review.create(book: book, customer: customers[Random.rand(0..9)], title: Faker::Lorem.sentence(2), rating: Random.rand(1..5), review_text: Faker::Lorem.paragraph(7))
  end
end


# tmp, debug customer orders
def create_oi(customer, order, book)
  
  OrderItem.create(customer: customer, order: order, book: book, price: book.price, quantity: Random.rand(1..5))
end

c = Customer.last
now = Date.current()
b = Book.find(20)
5.times do
  # completed
  o = Order.new(customer: c)
  o.state = :completed
  o.completed_date = now
  o.save
  Random.rand(2..8).times do
    OrderItem.create(order: o, book: b, price: b.price, quantity: Random.rand(1..5))
  end
  
  # shipped
  o = Order.new(customer: c)
  o.state = :shipped
  o.completed_date = now
  o.save
  Random.rand(2..8).times do
    OrderItem.create(order: o, book: b, price: b.price, quantity: Random.rand(1..5))
  end
end