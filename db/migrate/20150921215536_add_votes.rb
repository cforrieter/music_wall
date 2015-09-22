class AddVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.references :user
      t.references :song
      t.boolean :upvote, default: false
      t.timestamps null: false
    end
  end
end
