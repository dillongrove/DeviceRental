require 'test_helper'

class DeviceTest < ActiveSupport::TestCase
  
  should have_many :rentals
  should belong_to :os_version
  should belong_to :model
  
  should validate_presence_of :model_id
  should validate_presence_of :os_version_id
  
  context "Creating 1 model and 1 OS version" do
  
    setup do
      @galaxy         = FactoryGirl.create(:model)
      @indian_curry   = FactoryGirl.create(:os_version)
    end
    
    should "require model to exist" do
      
      m = FactoryGirl.build(:model)
      wrong = FactoryGirl.build(:device, :model => m)
      correct = FactoryGirl.build(:device, :model => @galaxy)
      
      deny wrong.valid?
      assert correct.valid?
      
    end
    
    should "require OS version to exist" do
      
      v = FactoryGirl.build(:os_version)
      wrong = FactoryGirl.build(:device, :os_version => v)
      correct = FactoryGirl.build(:device, :os_version => @indian_curry)
      
      deny wrong.valid?
      assert correct.valid?
      
    end
    
    should "require either IMEI or MEID to be present" do
    
      d = FactoryGirl.build(:device, :IMEI => nil, :MEID => nil)      
      deny d.valid?
      
      d.IMEI = "49-015420-323751"
      assert d.valid?
      
      d.IMEI = nil
      d.MEID = "49-015420-323751"
      assert d.valid?
    
    end
    
    teardown do
      [@galaxy, @indian_curry].map(&:destroy)
    end
  
  end
  
  context "Creating 2 active and 1 inactive devices" do
  
    setup do
      @d1 = FactoryGirl.create(:device, :IMEI => "49-015420-323752", :MEID => "49-015420-323752")
      @d2 = FactoryGirl.create(:device, :IMEI => "49-015420-323753", :MEID => nil)
      @d3 = FactoryGirl.create(:device, :IMEI => nil, :MEID => "49-015420-323751",
                                                                  :active => false)
    end
    
    should "return a list of active devices" do
      assert_equal 3, Device.all.length
      assert_equal 2, Device.active.length
    end
    
    should validate_uniqueness_of :MEID
    should validate_uniqueness_of :IMEI
    
    teardown do
      [@d1, @d2, @d3].map(&:destroy)
    end
  
  end
  
end
