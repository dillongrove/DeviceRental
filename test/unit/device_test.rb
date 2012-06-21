require 'test_helper'

class DeviceTest < ActiveSupport::TestCase
  # Test relationships
  should have_many :rentals
  should belong_to :os_version
  should belong_to :model
  
  # Test basic validations
  should validate_presence_of :model_id
  should validate_presence_of :os_version_id
  
  # Testing MEID
  should allow_value("A0-123456-123456").for(:MEID)
  should allow_value("ab-abcdef-abcdef").for(:MEID)
  should allow_value("ababcdefabcdef").for(:MEID)
  should allow_value("12123456123456").for(:MEID)
  should_not allow_value("121234561234567").for(:MEID) # one too many characters
  should_not allow_value("1212345612345").for(:MEID) # one two few characters
  should_not allow_value("ababcdefabcdeg").for(:MEID)# contains a non-hex character
  
  # Testing IMEI
  should allow_value("12-123456-123456-12").for(:IMEI)
  should allow_value("12-123456-123456-1").for(:IMEI)
  should allow_value("12-123456-123456").for(:IMEI)
  should allow_value("1212345612345612").for(:IMEI)
  should allow_value("121234561234561").for(:IMEI)
  should allow_value("12123456123456").for(:IMEI)
  should_not allow_value("12123456123456123").for(:IMEI) # one too many characters
  should_not allow_value("1212345612345").for(:IMEI) # one too few characters
  should_not allow_value("A0-123456-123456").for(:IMEI) # contains a non-digit
  should_not allow_value("12-123456-123456-").for(:IMEI) # contains a trailing dash
  

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
    
    should "show that we can correctly reformat IMEIs and MEIDs" do
      @a = FactoryGirl.create(:device, :IMEI => "49-015420-323751", :MEID => nil)
      assert_equal "49015420323751", @a.IMEI
      
      @b = FactoryGirl.create(:device, :IMEI => nil, :MEID => "A0-123456-123456")
      assert_equal "A0123456123456", @b.MEID
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
