class CreateDevices < ActiveRecord::Migration
  def change
    create_table :devices do |t|
      t.integer :id
      t.integer :model_id
      t.integer :os_ver_id
      t.boolean :active
      t.string :IMEI
      t.string :MEID
      t.string :condition

      t.timestamps
    end
  end
end
