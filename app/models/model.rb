class Model < ActiveRecord::Base

  attr_accessible :image, :image_attributes, :brand_id, :id, :name, :network_generation, :number, :os_type_id, :primary_camera_mp, :screen_size_inches, :screen_size_x_pixels, :screen_size_y_pixels, :secondary_camera_mp, :form_factor
  
  # Relationships --------------------------------------------------------------
  has_many :model_features
  has_many :devices
  belongs_to :os_type
  belongs_to :brand

  # Image Uploader -------------------------------------------------------------
  mount_uploader :image, ImageUploader
  
  # Scopes ---------------------------------------------------------------------
  
  # Misc Constants -------------------------------------------------------------
  NETWORK_GENERATIONS = [:'3G', :'4G'] 
  FORM_FACTORS = [['Handset', 'handset'], ['Tablet', 'tablet']]
  
  # Validations ----------------------------------------------------------------
  validates_presence_of :brand_id, :name, :network_generation, :number, :os_type_id, :screen_size_x_pixels, :screen_size_y_pixels, :form_factor
  # if primary/secondary camera details missing, that means no primary/secondary camera
  # IDEA: maybe we don't even need these details - just google on demand!!!!!
  
  # TODO: minimum length for name, model_number?
  validates_numericality_of :screen_size_x_pixels, :screen_size_y_pixels
  validates_numericality_of :primary_camera_mp, :secondary_camera_mp, :allow_blank => true
  validates_inclusion_of :network_generation, :in => %w[3G 4G]
  validates_inclusion_of :form_factor, :in => FORM_FACTORS.map { |a,b| b }, :message => "not recognized"
  validate :brand_must_exist
  validate :os_type_must_exist

  def form_factor?(in_form_factor)
    return form_factor.downcase.to_sym == in_form_factor
  end

  def os?(os)
    return os_type = os
  end
  
  private
  
  def brand_must_exist
    return if self.brand_id.nil?
    errors.add(:brand_id, "must be an existing brand.") if Brand.find(self.brand_id).nil?
  end
  
  def os_type_must_exist
    return if self.os_type_id.nil?
    errors.add(:os_type_id, "must be an existing OS.") if OsType.find(self.os_type_id).nil?
  end
  
end
