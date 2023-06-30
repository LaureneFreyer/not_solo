class ChangeReservationStatusDefaul < ActiveRecord::Migration[7.0]
  def change
    change_column_default :reservations, :status, from: "pending", to: "en attente"
  end
end
