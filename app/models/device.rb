# Device
class Device < ActiveRecord::Base
  before_save :reformat_IMEI
  before_save :reformat_MEID
  
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
  
  validate :model_must_exist
  validate :os_version_must_exist
  validate :presence_of_IMEI_or_MEID
  validates_uniqueness_of :IMEI, :allow_blank => true
  validates_uniqueness_of :MEID, :allow_blank => true
  
  validates_format_of :IMEI, :with => /^\d{2}[-]?\d{6}[-]?\d{6}([-]?\d{1,2})?$/, :message => "should be in the format AA-BBBBBB-CCCCCC with an optional -D or -DD at the end, and contain only digits.", :allow_blank => true
  validates_format_of :MEID, :with => /^[0-9A-Fa-f]{2}[-]?[0-9A-Fa-f]{6}[-]?[0-9A-Fa-f]{6}$/, :message => "should be in the format AA-BBBBBB-CCCCCC and contain only hexadecimal characters.", :allow_blank => true
  
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
  
  def reformat_IMEI
    return if self.IMEI.nil?
    imei = self.IMEI.to_s  # change to string in case input as all numbers 
    imei.gsub!(/[^0-9]/,"") # strip all non-digits
    self.IMEI = imei # reset self.IMEI to new string
  end

  def reformat_MEID
    return if self.MEID.nil?
    meid = self.MEID.to_s  # change to string in case input as all numbers 
    meid.gsub!(/[^0-9A-Fa-f]/,"") # strip all non-hexadecimal characters
    self.MEID = meid # reset self.MEID to new string
  end
  
end
