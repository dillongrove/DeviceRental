# Device Brand
# E.g. Samsung, HTC
class Brand < ActiveRecord::Base

  attr_accessible :id, :name
  
  # Relationships --------------------------------------------------------------
  has_many :models
  has_many :devices, :through => :models
  
  # Scopes ---------------------------------------------------------------------
  
  # Validations ----------------------------------------------------------------
  validates_presence_of :name
  # TODO: minimum length?
  
end
