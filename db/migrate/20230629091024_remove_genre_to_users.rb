class RemoveGenreToUsers < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :genre
  end
end
