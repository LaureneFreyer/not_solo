class AddGenreDefaultToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :genre, :string, default: "Féminin"
  end
end
