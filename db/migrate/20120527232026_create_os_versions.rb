class CreateOsVersions < ActiveRecord::Migration
  def change
    create_table :os_versions do |t|
      t.integer :id
      t.integer :os_type_id
      t.string :number
      t.string :name

      t.timestamps
    end
  end
end
