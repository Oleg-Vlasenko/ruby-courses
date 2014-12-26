class FixReviewFieldName < ActiveRecord::Migration
  def change
    rename_column :reviews, :review, :review_text
  end
end
