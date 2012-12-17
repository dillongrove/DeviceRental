# Operating System Version
class OsVersion < ActiveRecord::Base
  
  attr_accessible :id, :name, :number, :os_type_id
  
  # Relationships --------------------------------------------------------------
  belongs_to :os_type
  has_many :devices
  has_many :rentals, :through => :devices
  
  # Scopes ---------------------------------------------------------------------
  scope :for_os_type, lambda { |os_type_id| where('os_type_id = ?', os_type_id) }
  
  # Validations ----------------------------------------------------------------
  validates_presence_of :os_type_id, :number
  validate :os_must_exist
  
  # Methods
  private
  
  # checks that the associated os_type exists
  def os_must_exist
    return if self.os_type_id.nil?
    errors.add(:os_type_id, "must be an existing OS.") if OsType.find(self.os_type_id).nil?
  end
  
end
