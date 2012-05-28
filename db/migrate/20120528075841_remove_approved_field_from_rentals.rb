class RemoveApprovedFieldFromRentals < ActiveRecord::Migration
  
  def change
    remove_column :rentals, :approved
  end
  
end
