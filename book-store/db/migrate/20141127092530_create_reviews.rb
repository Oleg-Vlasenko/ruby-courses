class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.text :title
      t.text :review
      t.integer :rating
      t.references :book, index: true
      t.references :customer, index: true

      t.timestamps
    end
  end
end
