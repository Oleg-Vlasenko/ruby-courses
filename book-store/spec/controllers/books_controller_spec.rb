require 'rails_helper'

RSpec.describe BooksController, :type => :controller do
  let(:book) { mock_model('Book', id: '3') }
  let(:wrong_book_id) { '300' }

  before(:each) do
    Book.stub(:find_by_id).with(book.id).and_return(book)
    Book.stub(:find_by_id).with(wrong_book_id).and_return(nil)
  end

  describe 'Show book, GET index' do
    it 'assign selected book' do
      get :index, id: book.id
      expect(assigns[:book]).to eq(book)
    end

    it 'renders book card' do
      get :index, id: book.id
      expect(response).to render_template('index')
    end

    it 'raises error 404 if not find book' do
      expect { get :index, id: wrong_book_id }.to raise_error(ActionController::RoutingError, 'Not Found')
    end
  end
end
