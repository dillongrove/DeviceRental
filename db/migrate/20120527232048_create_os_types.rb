class CreateOsTypes < ActiveRecord::Migration
  def change
    create_table :os_types do |t|
      t.integer :id
      t.string :name

      t.timestamps
    end
  end
end
