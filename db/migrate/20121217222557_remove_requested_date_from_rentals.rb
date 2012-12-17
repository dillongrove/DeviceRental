class RemoveRequestedDateFromRentals < ActiveRecord::Migration
  def up
    remove_column :rentals, :requested_date
      end

  def down
    add_column :rentals, :requested_date, :datetime
  end
end
