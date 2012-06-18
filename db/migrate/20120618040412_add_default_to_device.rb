class AddDefaultToDevice < ActiveRecord::Migration
  
  def change
    remove_column :devices, :active
    add_column :devices, :active, :boolean, :default => true
  end

end
