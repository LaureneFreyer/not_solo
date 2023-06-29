class RemoveReservationFromChatroom < ActiveRecord::Migration[7.0]
  def change
    remove_reference :chatrooms, :reservation, null: false, foreign_key: true
  end
end
