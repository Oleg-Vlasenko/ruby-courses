class Order < ActiveRecord::Base
  @@states = [:in_progress, 'completed', :shipped]
  @@default_state = @@states[0]
  cattr_reader :states

  belongs_to :customer
  belongs_to :credit_card
  belongs_to :billing_address, class_name: 'Address'
  belongs_to :shipping_address, class_name: 'Address'
  has_many :items, class_name: 'OrderItem'

  before_validation :set_default_state

  validates :completed_date, presence: true, if: :completed?
  validates :state, presence: true
  validates :state, inclusion: { in: @@states }

  def subtotal_price
    self.items.sum(:total_sum)
  end

  def total_price
    self.subtotal_price.to_i + self.shipping.to_i
  end

  def add_book(book_id, quantity)
    return nil if self.new_record?

    book = Book.find_by_id(book_id)
    new_item = self.items.new(book: book, price: book.price, quantity: quantity)
    new_item.save
    return new_item
  end
  
  def set_completed
    self.state = @@states[1]
  end
  
  def set_shipped
    self.state = @@states[2]
  end
  
  def group_items
    
  end
  
  private

  def set_default_state
    self.state = @@default_state unless self.state
  end

  def completed?
    self.state == @@states[1] or self.state == @@states[2]
  end

end
