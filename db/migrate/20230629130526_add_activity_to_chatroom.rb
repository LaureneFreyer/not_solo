class AddActivityToChatroom < ActiveRecord::Migration[7.0]
  def change
    add_reference :chatrooms, :activity, null: false, foreign_key: true
  end
end
