# Device
class Device < ActiveRecord::Base

  attr_accessible :IMEI, :MEID, :active, :condition, :id, :model_id, :os_version_id
  
  # Relationships --------------------------------------------------------------
  has_many :rentals
  belongs_to :os_version
  belongs_to :model
  
  # Scopes ---------------------------------------------------------------------
  scope :active, where('active = ?', true)
  
  # Validations ----------------------------------------------------------------
  validates_presence_of :model_id, :os_version_id
  # active is not required -> defaults to true in the DB
  # MEID is optional -> only some devices, such as CDMA devices, have it
  
  validate :model_must_exist
  validate :os_version_must_exist
  validate :presence_of_IMEI_or_MEID
  
  # TODO: format for IMEI, MEID
  
  private
  
  def model_must_exist
    return if self.model_id.nil?
    errors.add(:model_id, "must be an existing model") if Model.find(self.model_id).nil?
  end
  
  def os_version_must_exist
    return if self.os_version_id.nil?
    errors.add(:os_version_id, "must be an existing OS version") if OsVersion.find(self.os_version_id).nil?
  end
  
  def presence_of_IMEI_or_MEID
    return if not (self.IMEI.nil? and self.MEID.nil?)
    errors.add(:IMEI, "Either IMEI or MEID must be present.")
  end
  
end
