# Operating System Type
# E.g. Android, iOS etc.
class OsType < ActiveRecord::Base

  attr_accessible :id, :name
  
  # Relationships --------------------------------------------------------------
  has_many :os_versions
  has_many :models
  
  # Scopes ---------------------------------------------------------------------
  
  
  # Validations ----------------------------------------------------------------
  validates_presence_of :name
  # TODO: minimum length?
  
end
