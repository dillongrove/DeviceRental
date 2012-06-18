# Device
class Device < ActiveRecord::Base

  attr_accessible :IMEI, :MEID, :active, :condition, :id, :model_id, :os_version_id
  
  # Relationships --------------------------------------------------------------
  has_many :rentals
  belongs_to :os_version
  belongs_to :model
  
  # Scopes ---------------------------------------------------------------------
  scope :active, where('active = ?', true)
  scope :for_os_version, lambda { |os_version_id| where('os_version_id = ?', os_version_id) }
  scope :for_model, lambda { |model_id| where('model_id = ?', model_id) }
  
  # Validations ----------------------------------------------------------------
  validates_presence_of :model_id, :os_version_id, :IMEI, :MEID
  # active is not required -> defaults to true in the DB
  
  validate :model_must_exist
  validate :os_version_must_exist
  
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
  
end
