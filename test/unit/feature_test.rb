require 'test_helper'

class FeatureTest < ActiveSupport::TestCase
  
  should have_many :model_features
  
  should validate_presence_of :name
  should allow_value("camera").for(:name)
  should allow_value("x").for(:name)
  should_not allow_value("").for(:name)
  should_not allow_value(nil).for(:name)
  
  context "Creating 3 features" do
  
    setup do
      @c = FactoryGirl.create(:feature, :name => 'c')
      @b = FactoryGirl.create(:feature, :name => 'b')
      @a = FactoryGirl.create(:feature, :name => 'a')
    end
    
    should "return list of features in alphabetical order" do
      assert_equal [@a, @b, @c].map(&:id), Feature.alphabetical.map(&:id)
    end
    
    teardown do
      [@a, @b, @c].map(&:destroy)
    end
  
  end
  
end
