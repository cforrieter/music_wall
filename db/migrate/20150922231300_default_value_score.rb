class DefaultValueScore < ActiveRecord::Migration
  def change
    change_column_default(:songs, :score, 0)
  end
end
