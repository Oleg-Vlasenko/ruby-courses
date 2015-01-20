class Customer < ActiveRecord::Base
  # attr_accessor :current_order

  has_many :orders
  has_many :reviews

  has_secure_password

  validates :email, format: { with: /\A.+@.+\..+\z/ , message: 'Not valid email!' }, uniqueness: true
  validates :first_name, :last_name, presence: true

  def name
    first_name + ' ' + last_name
  end
  
  def get_current_order
    Order.where(customer: self, state: :in_progress).first
  end
  
  def get_current_order_info
    order = get_current_order
    if order
      if order.items.length > 0
        return "(#{order.items.length}) $#{'%.2f' % order.total_price}"
      else
        return '(EMPTY)'
      end
    else
      return ''
    end
  end
  
  def get_current_order!
    order = Order.where(customer: self, state: :in_progress).first
    if !order
      order = Order.new(customer: self)
      order.save
    end
    return order
  end
  
  def get_orders(state)
    Order.where(customer: self, state: state)
  end
end