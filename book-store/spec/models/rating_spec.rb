require 'rails_helper'

RSpec.describe Rating, :type => :model do
  # rating_number should be from one to five
  # Should belong to customer and book

  let(:rating) { FactoryGirl.build(:rating) }

  context 'validates' do
    it 'rating_number should be from one to five' do
      expect(rating).to validate_numericality_of(:rating_number).is_greater_than_or_equal_to(1).is_less_than_or_equal_to(5)
    end
  end

  context 'associations' do
    it 'rating should belong to customer' do
      expect(rating).to belong_to(:customer)
    end

    it 'rating should belong to book' do
      expect(rating).to belong_to(:book)
    end
  end

end
