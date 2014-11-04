class Customer < ActiveRecord::Base
  # attr_accessor :current_order

  has_many :orders
  has_many :ratings

  validates :email, presence: true, uniqueness: true
  validates :password, :first_name, :last_name, presence: true

  def name
    first_name + ' ' + last_name
  end
end