# Rental User - tied to an Andrew account. Note that all associated rentals are
# destroyed if a user is deleted. On creation, a user must have an andrew ID,
# a role, and an email address.
#
# WARNING: depending on how the user is created, a hacker might hide role information
# in his post request to force his user to be an administrator. Need to check for
# that in the controller.
class User < ActiveRecord::Base

  attr_accessible :id, :andrew, :email, :role
  
  # Relationships --------------------------------------------------------------
  has_many :rentals, :dependent => :destroy
  has_many :devices, :through => :rentals
  
  # Scopes ---------------------------------------------------------------------
  
  # a user may be admin or a regular renter
  ROLES = [['Administrator', 'admin'], ['Regular', 'regular']]

  scope :for_role, lambda { |role| where('role = ?', role) }
  scope :admins, for_role('admin')
  scope :regulars, for_role('regular')
  scope :alphabetical, order(:andrew)
  
  # Validations ----------------------------------------------------------------

  validates_presence_of :andrew, :role, :email
  validates_uniqueness_of :andrew, :email, :message => "has already been registered"
  validates_inclusion_of :role, :in => ROLES.map { |a,b| b }
  validates :email, :email => true
  
  # no validations for andrew id, since we are probably taking it from Shibboleth
  
  # Callbacks ------------------------------------------------------------------
  
  alias :old_to_s :to_s
  # return andrew ID as string representation of a user
  def to_s
    self.andrew
  end
  
end
