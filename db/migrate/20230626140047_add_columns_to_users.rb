class AddColumnsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :nickname, :string
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :address, :string
    add_column :users, :type, :string
    add_column :users, :points, :integer
    add_column :users, :birthday, :date
    add_column :users, :description, :text
    add_column :users, :interest, :string
  end
end
