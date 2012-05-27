class CreateModels < ActiveRecord::Migration
  def change
    create_table :models do |t|
      t.integer :id
      t.string :name
      t.string :number
      t.integer :brand_id
      t.string :network_generation
      t.integer :os_type_id
      t.float :screen_size_inches
      t.integer :screen_size_x_pixels
      t.integer :screen_size_y_pixels
      t.float :primary_camera_mp
      t.float :secondary_camera_mp

      t.timestamps
    end
  end
end
