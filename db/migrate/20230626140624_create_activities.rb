class CreateActivities < ActiveRecord::Migration[7.0]
  def change
    create_table :activities do |t|
      t.string :category
      t.float :latitude
      t.float :longitude
      t.string :title
      t.float :price_person
      t.text :content
      t.string :address
      t.datetime :start_date
      t.datetime :end_date

      t.timestamps
    end
  end
end
