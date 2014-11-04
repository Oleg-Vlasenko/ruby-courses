class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.text :title
      t.text :review
      t.integer :rating_number
      t.references :book, index: true
      t.references :customer, index: true

      t.timestamps
    end
  end
end
