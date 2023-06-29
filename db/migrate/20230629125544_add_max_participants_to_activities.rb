class AddMaxParticipantsToActivities < ActiveRecord::Migration[7.0]
  def change
    add_column :activities, :max_participants, :integer
  end
end
