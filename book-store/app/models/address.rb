class Address < ActiveRecord::Base
  has_many :orders
  belongs_to :country

  validates :address, :phone, :zip_code, :city, :country, presence: true
end
