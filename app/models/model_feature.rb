class ModelFeature < ActiveRecord::Base

  attr_accessible :feature_id, :id, :model_id
  
  # Relationships --------------------------------------------------------------
  belongs_to :feature
  belongs_to :model
  
  # Validations ----------------------------------------------------------------
  validates_presence_of :feature_id
  validates_presence_of :model_id
  validate :feature_must_exist
  validate :model_must_exist
  
  private
  
  def feature_must_exist
    return if self.feature_id.nil?
    errors.add(:feature_id, "must be an existing feature") if Feature.find(self.feature_id).nil?
  end
  
  def model_must_exist
    return if self.model_id.nil?
    errors.add(:model_id, "must be an existing model") if Model.find(self.model_id).nil?
  end
  
end
