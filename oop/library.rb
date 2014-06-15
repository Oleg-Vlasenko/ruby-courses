require 'date'

class Order
  attr_reader :book, :name, :order_date
  attr_accessor :issue_date

  def initialize(book, name, order_date)
    @book, @name, @order_date = book, name, order_date
  end
end

class Library
  def initialize(books)
    @books = books
    @orders = []
  end

  def get_order(book, name, order_date)
    order = Order.new(book, name, order_date)
    @orders << order

    order
  end

  def close_order(order, issue_date)
    if idx = @orders.index(order)
      @orders[idx].issue_date = issue_date
    end

  end

  def min_orders_period
    min = nil
    @orders.each do |order|
      if order.issue_date
        period = (order.issue_date - order.order_date).to_i
        min = period if !min || min > period
      end
    end
    min
  end

  def not_satisfied
    count = 0
    @orders.each { |order| count += 1 if !order.issue_date }
    count
  end

  def often_takes_book
    readers = []; books = {}
    @orders.each { |order| books.key?(order.name) ? books[order.name] += 1 : books[order.name] = 1 }
    books.each_key { |key| readers << key if books[key] > 2 }
    readers
  end

  def most_popular
    books = books_count
    max = books.max_by { |key, val| val }
    max[0]
  end

  def ordered_most_popular
    books = books_count
    books = books.sort_by { |key, val| val }.reverse
    books[0][1] + books[1][1] + books[2][1]
  end

  private
  def books_count
    books = {}
    @orders.each { |order| books.key?(order.book) ? books[order.book] += 1 : books[order.book] = 1 }
    books
  end

end

books = ['The Book Thief', '1984', 'To Kill a Mockingbird', 'The Da Vinci Code', 'Alice\'s Adventures in Wonderland']
lib = Library.new(books)

reader = 'Dan'
order1 = lib.get_order(books[0], reader, Date.new(2011, 01, 10))
order2 = lib.get_order(books[1], reader, Date.new(2014, 01, 10))
order3 = lib.get_order(books[2], reader, Date.new(2012, 01, 10))
order4 = lib.get_order(books[3], reader, Date.new(2010, 01, 10))
lib.close_order(order1, Date.new(2011, 01, 31))
lib.close_order(order2, Date.new(2014, 02, 01))
lib.close_order(order3, Date.new(2012, 03, 01))

reader = 'Ian'
order1 = lib.get_order(books[0], reader, Date.new(2012, 01, 10))
order2 = lib.get_order(books[1], reader, Date.new(2011, 01, 10))
order3 = lib.get_order(books[2], reader, Date.new(2010, 01, 10))
lib.close_order(order1, Date.new(2012, 04, 10))
lib.close_order(order2, Date.new(2011, 04, 10))
lib.close_order(order3, Date.new(2010, 02, 10))

reader = 'Dave'
order1 = lib.get_order(books[1], reader, Date.new(2011, 01, 10))
order2 = lib.get_order(books[2], reader, Date.new(2014, 01, 10))
lib.close_order(order1, Date.new(2011, 05, 01))

reader = 'Lucy'
order1 = lib.get_order(books[0], reader, Date.new(2014, 01, 10))
order2 = lib.get_order(books[1], reader, Date.new(2011, 01, 10))
order3 = lib.get_order(books[2], reader, Date.new(2010, 01, 10))
order4 = lib.get_order(books[4], reader, Date.new(2010, 01, 10))
lib.close_order(order1, Date.new(2014, 03, 10))
lib.close_order(order2, Date.new(2011, 02, 20))
lib.close_order(order4, Date.new(2010, 03, 25))

p lib.min_orders_period
p lib.not_satisfied
p lib.often_takes_book
p lib.most_popular
p lib.ordered_most_popular