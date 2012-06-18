class Feature < ActiveRecord::Base

  attr_accessible :id, :name
  
  # Relationships --------------------------------------------------------------
  has_many :model_features
  
  # Scopes ---------------------------------------------------------------------
  
  
  # Validations ----------------------------------------------------------------
  validates_presence_of :name
  # TODO: minimum length?
  
end
