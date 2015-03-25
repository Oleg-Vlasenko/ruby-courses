class Customer < ActiveRecord::Base
  include AddressOwner

  has_many :orders
  has_many :reviews
  belongs_to :billing_address
  belongs_to :shipping_address

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
  
  def change_password(password)
    result = true
    unless password[:current].blank? || password[:new].blank?
      if self.authenticate(password[:current])
        self.password = password[:new]
      else
        result = false
      end
    end
    result
  end

  def update_settings(upd_data)
    set_billing_address(upd_data[:billing_address])
    set_shipping_address(upd_data[:shipping_address])

    unless change_password(upd_data[:password])
      self.errors.add(:authenticate, 'incorrect password')
    end
    
    update(upd_data[:customer])
    
    if self.valid? && self.billing_address.valid? && self.shipping_address.valid? && !self.errors.any?
      true
    else
      false
    end
  end
  
  def _test_update_settings(upd_data)
    p 'test_info'
    p "***"
    p upd_data
    
    test_data = Hash.new
    test_data[:upd_data] = upd_data
    
    test_data[:billing_address] = Hash.new
    if self.billing_address
      test_data[:billing_address][:upd_meth] = 'update'
      p "***" 
      p 'update billing_address'
      p upd_data[:billing_address]
      #bm Todo 
      # in rails c
      # Address.find(c.billing_address).update("first_name"=>"Ol", "last_name"=>"", "address"=>"paddres", "city"=>"q", "zip_code"=>"zzzd-555", "phone"=>"555-55-55")
      Address.find(self.billing_address).update(upd_data[:billing_address])
    else
      test_data[:billing_address][:upd_meth] = 'create'
      p "***" 
      p 'new billing_address'
      p upd_data[:billing_address]
      self.billing_address = Address.new(upd_data[:billing_address])
      self.billing_address.save
    end

    test_data[:shipping_address] = Hash.new
    if self.shipping_address
      p "***" 
      p 'update shipping_address'
      p upd_data[:shipping_address]
      test_data[:shipping_address][:upd_meth] = 'update'
      self.shipping_address.update(upd_data[:shipping_address])
    else
      p "***" 
      p 'new shipping_address'
      p upd_data[:shipping_addresss]
      test_data[:shipping_address][:upd_meth] = 'create'
      self.shipping_address = Address.new(upd_data[:shipping_address])
      self.shipping_address.save
    end
    
    password = upd_data[:password]
    
    test_data[:password] = Hash.new
    test_data[:password][:current] = password[:current]
    test_data[:password][:new] = password[:new]
    unless password[:current].blank? || password[:new].blank?
      if self.authenticate(password[:current])
        test_data[:password][:authenticate] = true
        self.password = password[:new]
      else
        test_data[:password][:authenticate] = false
        result = false
      end
    else
      test_data[:password][:authenticate] = 'none'
    end

    unless change_password(upd_data[:password])
      self.errors.add(:authenticate, 'incorrect password')
      test_data[:password][:authenticate_error] = 'incorrect password'
    else
      test_data[:password][:authenticate_error] = 'none'
    end
    
    self.update(upd_data[:customer])
    
    test_data[:valid] = Hash.new
    test_data[:valid][:customer] = self.valid
    test_data[:valid][:billing_address] = self.billing_address
    test_data[:valid][:shipping_address] = self.shipping_address
    
    if self.valid? && self.billing_address.valid? && self.shipping_address.valid? && !self.errors.any?
      test_data[:result] = true
    else
      test_data[:result] = false
    end
    test_data
  end
end