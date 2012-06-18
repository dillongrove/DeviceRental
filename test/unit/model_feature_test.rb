require 'test_helper'

class ModelFeatureTest < ActiveSupport::TestCase

  should belong_to :model
  should belong_to :feature
  
  should validate_presence_of :feature_id
  should validate_presence_of :model_id
  
  context "Creating 1 model and 1 feature" do
  
    setup do
      @eyetracking = FactoryGirl.create(:feature)
      @galaxy = FactoryGirl.create(:model)
    end
    
    should "require feature to exist" do
      
      # feature that is not in DB yet
      infinite_battery_file = FactoryGirl.build(:feature, :name => "Infinite Battery Life")
      
      fake = FactoryGirl.build(:model_feature, :model => @galaxy, :feature => infinite_battery_file)
      real = FactoryGirl.build(:model_feature, :model => @galaxy, :feature => @eyetracking)
      
      deny fake.valid?
      assert real.valid?
       
    end
    
    should "require model to exist" do
      
      # model that is not in DB yet
      galaxy_sx = FactoryGirl.build(:model, :name => "Galaxy SX")
      
      fake = FactoryGirl.build(:model_feature, :model => galaxy_sx, :feature => @eyetracking)
      real = FactoryGirl.build(:model_feature, :model => @galaxy, :feature => @eyetracking)
      
      deny fake.valid?
      assert real.valid?
      
    end
    
    teardown do
      @eyetracking.destroy
      @galaxy.destroy
    end
  
  end

end
