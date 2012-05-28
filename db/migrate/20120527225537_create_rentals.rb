# Rental Record
#
# Every rental has created_at, requested_date, loan_date, end_date, return_date, and approve_date
#    created_at:      when this record was created (i.e. when the user used this website)
#    requested_date:  the user says, "I intend to start on this date"
#    approve_date:    when this rental was approved
#    loan_date:       the actual date we loaned it to him
#    end_date:        the user says, "I intend to return on this date"
#    return_date:     the actual date it was returned to us
class CreateRentals < ActiveRecord::Migration
  def change
    create_table :rentals do |t|
    
      t.integer :id
      t.integer :device_id
      t.integer :user_id

      t.datetime :requested_date
      t.datetime :approve_date
      t.datetime :loan_date
      t.datetime :end_date
      t.datetime :return_date

      t.boolean :approved

      t.timestamps
      
    end
  end
end
