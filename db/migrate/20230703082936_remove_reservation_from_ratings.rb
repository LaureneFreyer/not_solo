class RemoveReservationFromRatings < ActiveRecord::Migration[7.0]
  def change
    remove_reference :ratings, :reservation, null: false, foreign_key: true
  end
end
