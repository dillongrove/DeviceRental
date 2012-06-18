class Model < ActiveRecord::Base

  attr_accessible :brand_id, :id, :name, :network_generation, :number, :os_type_id, :primary_camera_mp, :screen_size_inches, :screen_size_x_pixels, :screen_size_y_pixels, :secondary_camera_mp
  
  # Relationships --------------------------------------------------------------
  # Scopes ---------------------------------------------------------------------
  # Validations ----------------------------------------------------------------
  
end
