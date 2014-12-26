require 'rails_helper'

RSpec.describe "books/index", :type => :view do
  let (:author) { mock_model('Author', {name: Faker::Name.name}) }
  let (:customer) { mock_model('Customer', {name: Faker::Name.name}) }
  let(:ratings) do
    ratings = []
    2.times { ratings << mock_model('Rating', {title: Faker::Lorem.sentence(2),
                                               customer: customer,
                                               rating_number: Random.rand(1..5),
                                               review: Faker::Lorem.sentence(4),
                                               created_at: DateTime.now}) }
    ratings
  end
  let(:book) { mock_model('Book', {title: Faker::Lorem.sentence(2),
                                   price: Random.rand(5..20),
                                   author: author,
                                   description: Faker::Lorem.sentence(4),
                                   ratings: ratings}) }

  before(:each) do
    assign(:book, book)

    render
  end

  context 'book data' do
    it 'renders book title' do
      expect(rendered).to have_selector('#book-title', text: book.title)
    end

    it 'renders book author' do
      expect(rendered).to have_selector('#author-name', text: author.name)
    end

    it 'renders book price' do
      expect(rendered).to have_selector('#book-price', text: book.price)
    end

    it 'renders book description' do
      expect(rendered).to have_selector('#book-description', text: book.description)
    end
  end

  context 'reviews' do
    it 'renders rating' do
      expect(rendered).to have_selector('.rating > .star-checked')
    end

    it 'renders review title' do
      expect(rendered).to have_selector('.rating-title', text: ratings[0].title)
    end

    it 'renders review author' do
      expect(rendered).to have_selector('.rating-author', text: ratings[0].customer.name)
    end

    it 'renders review date' do
      expect(rendered).to have_selector('.rating-date', text: ratings[0].created_at.strftime("%b %d, %Y"))
    end

    it 'renders review' do
      expect(rendered).to have_selector('.rating-review', text: ratings[0].review)
    end

    it 'renders link for adding new review' do
      expect(rendered).to have_selector('a.add-review')
    end
  end

  it 'renders "add to order" form' do
    expect(rendered).to have_selector('form > input#books_amount')
  end
end
