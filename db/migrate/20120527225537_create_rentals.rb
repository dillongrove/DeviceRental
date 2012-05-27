class CreateRentals < ActiveRecord::Migration
  def change
    create_table :rentals do |t|
      t.integer :id
      t.integer :device_id
      t.integer :user_id
      t.datetime :start_date
      t.datetime :end_date
      t.datetime :date_requested
      t.string :stage

      t.timestamps
    end
  end
end
