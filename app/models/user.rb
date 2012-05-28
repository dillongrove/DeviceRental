# Rental User - tied to an Andrew account. Note that all associated rentals are
# destroyed if a user is deleted. On creation, a user must have an andrew ID,
# a role, and an email address.
#
# WARNING: depending on how the user is created, a hacker might hide role information
# in his post request to force his user to be an administrator. Need to check for
# that.
class User < ActiveRecord::Base

  attr_accessible :andrew, :email, :id, :role
  
  # Relationships --------------------------------------------------------------
  has_many :rentals, :dependent => :destroy
  has_many :devices, :through => :rentals
  
  # Scopes ---------------------------------------------------------------------
  
  # a user may be admin or a regular renter
  ROLES = [['Administrator', 'admin'], ['Regular', 'regular']]

  scope :admins, where('role = ?', 'admin')
  scope :regulars, where('role = ?', 'regular')
  scope :alphabetical, order('andrew')
  
  # Validations ----------------------------------------------------------------

  validate_presence_of :andrew, :role, :email
  validate_uniqueness_of :andrew, :email, :message => "has already been registered"
  validate_inclusion_of :role, :in => ROLES.map { |a,b| b }
  validate :email, :email => true, :message => "is not a valid email address"
  
  # no validations for andrew id, since we are probably taking it from Shibboleth
  
  # Callbacks ------------------------------------------------------------------
  
end
