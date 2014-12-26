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
end