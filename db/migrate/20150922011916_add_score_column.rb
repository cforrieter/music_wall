class AddScoreColumn < ActiveRecord::Migration
  def change
    change_table :songs do |t|
      t.integer :score
      t.references :user
    end
  end
end
