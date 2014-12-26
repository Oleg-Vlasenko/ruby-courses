require 'rails_helper'

RSpec.describe CustomersController, :type => :controller do
  describe "GET new" do
    let(:new_customer) { mock_model('Customer') }

    before(:each) do
      Customer.stub(:new).and_return(new_customer)
    end

    it 'assigns customer' do
      get :new
      expect(assigns(:customer)).to eq(new_customer)
    end
  end

  describe "POST create" do
    let(:customer) { mock_model('Customer', email: Faker::Internet.email) }
    let(:params) { { email: customer.email } }
    let(:wrong_customer) { mock_model('Customer', email: 'wRONGeMAIL') }
    let(:wrong_params) { { email: wrong_customer.email } }

    before(:each) do
      Customer.stub(:new).with(params).and_return(customer)
      Customer.stub(:new).with(wrong_params).and_return(wrong_customer)
      customer.stub(:save).and_return(true)
      wrong_customer.stub(:save).and_return(false)
    end

    it 'create customer' do
      post :create, { customer: params }
      expect(assigns(:customer)).to eq(customer)
    end

    it 'assigns session variable for saved customer' do
      post :create, { customer: params }
      expect(session[:customer_id]).to eq(customer.id)
    end

    it 're-display new customer form if customer not created' do
      post :create, { customer: wrong_params }
      expect(response).to render_template('new')
    end
  end

end
