require 'test_helper'

class FeatureTest < ActiveSupport::TestCase
  
  should have_many :model_features
  
  should validate_presence_of :name
  should allow_value("camera").for(:name)
  should allow_value("x").for(:name)
  should_not allow_value("").for(:name)
  should_not allow_value(nil).for(:name)
  
end
