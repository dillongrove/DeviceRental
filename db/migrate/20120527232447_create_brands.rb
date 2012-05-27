class CreateBrands < ActiveRecord::Migration
  def change
    create_table :brands do |t|
      t.integer :id
      t.string :name

      t.timestamps
    end
  end
end
