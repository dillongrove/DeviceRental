require 'test_helper'

class OsVersionTest < ActiveSupport::TestCase
  
  should belong_to :os_type
  should have_many :devices
  should have_many(:rentals).through(:devices)
  
  should validate_presence_of :os_type_id
  should validate_presence_of :number
  should validate_presence_of :name
  
  context "Creating one Android OS", do
    
    setup do
      @android = FactoryGirl.create(:os_type)
    end
    
    should "require os_type to exist" do
    
      # build an OS that does not exist in DB yet
      lemon = FactoryGirl.build(:os_type, :name => "lemon")
      
      bland_indian_curry = FactoryGirl.build(:os_version, :os_type => nil)
      non_spicy_indian_curry = FactoryGirl.build(:os_version, :os_type => lemon)
      spicy_indian_curry = FactoryGirl.build(:os_version, :os_type => @android)
      
      deny bland_indian_curry.valid?
      deny non_spicy_indian_curry.valid?
      assert spicy_indian_curry.valid?
      
    end
    
    teardown do
      @android.destroy
    end
    
  end
  
end
