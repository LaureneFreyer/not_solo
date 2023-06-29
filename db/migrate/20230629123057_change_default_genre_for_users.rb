class ChangeDefaultGenreForUsers < ActiveRecord::Migration[7.0]
  def change
    change_column_default :users, :genre, "Autre"
  end
end
