class SetDefaultValueForUserRole < ActiveRecord::Migration
  
  def change
    remove_column :users, :role
    add_column :users, :role, :string, :default => 'regular'
  end
  
end
