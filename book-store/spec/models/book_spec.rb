require 'rails_helper'

RSpec.describe Book, :type => :model do
  # Title, price, books in stock fields should be required
  # how many books in stock (просто поле остаток?)
  # Should belong to author and category
  # Should have many ratings from customers

  let(:book) { FactoryGirl.create(:book) }

  context 'validates' do
    it 'title should be required' do
      expect(book).to validate_presence_of(:title)
    end

    it 'price should be required' do
      expect(book).to validate_presence_of(:price)
    end

    it 'price should be greater than zero' do
      expect(book).to validate_numericality_of(:price).is_greater_than(0)
    end

    it 'books in stock should be required' do
      expect(book).to validate_presence_of(:stock)
    end

    it 'stock should be greater than zero' do
      expect(book).to validate_numericality_of(:stock).is_greater_than(0)
    end

  end

  context 'associations' do
    it 'book should belong to author' do
      expect(book).to belong_to(:author)
    end

    it 'book should belong to category' do
      expect(book).to belong_to(:category)
    end

    pending 'book should have many ratings'
    # it 'book should have many ratings' do
    #   expect(book).to have_many(:ratings)
    # end
  end

  context 'functionality' do

    pending 'book should find books for page'
    pending 'book should find books for page by category'
    pending 'book should find a previous book'
    pending 'book should find a next book'

  end
end
