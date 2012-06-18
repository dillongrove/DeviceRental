require 'test_helper'

class FeatureTest < ActiveSupport::TestCase
  
  should validate_presence_of :name
  should have_many :model_features
  
end
