require 'rails_helper'

RSpec.describe Customer, :type => :model do
  # Rewrite tests for authenticate functionality
  # Email, password, first_name, last_name fields should be required
  # Email should be unique
  # Should have many orders, ratings
  # A customer should be able to create a new order
  # A customer should be able to return a current order in progress

  let(:customer) { FactoryGirl.build(:customer) }

  context 'validates' do
    it 'email should be required' do
      expect(customer).to validate_presence_of(:email)
    end

    it 'email should be unique' do
      expect(customer).to validate_uniqueness_of(:email)
    end

    it 'password should be required' do
      expect(customer).to validate_presence_of(:password)
    end

    it 'first_name should be required' do
      expect(customer).to validate_presence_of(:first_name)
    end

    it 'last_name should be required' do
      expect(customer).to validate_presence_of(:last_name)
    end
  end

  context 'associations' do
    pending 'customer should have many orders'
    # it 'customer should have many orders' do
    #   expect(customer).to have_many(:orders)
    # end

    it 'customer should have many ratings' do
      expect(customer).to have_many(:ratings)
    end
  end

  context 'functionality' do
    pending 'customer should be able to create a new order'
    # it 'customer should be able to create a new order' do
    #   expect(customer.orders).to respond_to :new
    #   new_order = customer.orders.new
    #   expect(new_order).to be_an_instance_of(Order)
    # end

    it 'customer should return self name' do
      expect(customer.name).to eq(customer.first_name + ' ' + customer.last_name)
    end
    
    pending 'customer should be able to return a current order in progress'
  end

end
