class AddActivityToRatings < ActiveRecord::Migration[7.0]
  def change
    add_reference :ratings, :activity, null: false, foreign_key: true
  end
end
