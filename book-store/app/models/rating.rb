class Rating < ActiveRecord::Base
  belongs_to :book
  belongs_to :customer

  validates :rating_number, presence: true, numericality: {greater_than_or_equal_to: 1, less_than_or_equal_to: 5}

  # COLORS = [
  #     'red',
  #     'green',
  #     'blue'
  # ]
  #
  # redef before_validation
  #
  # def validate_color
  #   COLORS.detect self.color
  # end

end
