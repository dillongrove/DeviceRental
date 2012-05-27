class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.integer :id
      t.string :andrew
      t.string :role
      t.string :email

      t.timestamps
    end
  end
end
