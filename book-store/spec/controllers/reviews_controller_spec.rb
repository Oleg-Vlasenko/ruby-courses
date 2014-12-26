require 'rails_helper'

RSpec.describe ReviewsController, :type => :controller do
  describe "GET new" do
    let(:new_review) { mock_model('Review') }

    before(:each) do
      Review.stub(:new).and_return(new_review)
    end

    it 'assigns review' do
      get :new, book_id: 1
      expect(assigns(:review)).to eq(new_review)
    end

    # pending 'set review rating of 1'
    # pending 'set current user as review\'s customer'
    # pending 'set selected book as review\'s book'
  end

  describe "POST create" do
    let(:review) { mock_model('Review') }
    let(:params) { {rating: "5"} }
    # let(:params) { ActionController::Parameters.new({rating: "5"}) }
    let(:wrong_review) { mock_model('Review') }
    let(:wrong_params) { {rating: 100} }

    before(:each) do
      Review.stub(:new).with(params).and_return(review)
      Review.stub(:new).with(wrong_params).and_return(wrong_review)
      review.stub(:save).and_return(true)
      wrong_review.stub(:save).and_return(false)
    end

    it 'create review' do
      post :create, {book_id: 1, review: params}
      expect(assigns(:review)).to eq(review)
    end

    pending 'redirect to book page if review created'
    pending 're-display new review form if review not created'


    #   it 'create customer' do
    #     post :create, { customer: params }
    #     expect(assigns(:customer)).to eq(customer)
    #   end
    #
    #   it 'assigns session variable for saved customer' do
    #     post :create, { customer: params }
    #     expect(session[:customer_id]).to eq(customer.id)
    #   end
    #
    #   it 're-display new customer form if customer not created' do
    #     post :create, { customer: wrong_params }
    #     expect(response).to render_template('new')
    #   end
  end

end
