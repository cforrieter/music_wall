class AddReviews < ActiveRecord::Migration
  def change
    change_table :votes do |t|
      t.text :review
      t.integer :review_rating
    end
  end
end
