require 'test_helper'

class BrandTest < ActiveSupport::TestCase
  
  should have_many :models
  should have_many(:devices).through(:models)
  
  should validate_presence_of :name
  
  should allow_value("samsung").for(:name)
  should allow_value("htc").for(:name)
  should_not allow_value("").for(:name)
  should_not allow_value(nil).for(:name)
  
  context "Creating 3 brands" do
  
    setup do
      @htc = FactoryGirl.create(:brand)
      @samsung = FactoryGirl.create(:brand, :name => 'Samsung')
      @apple = FactoryGirl.create(:brand, :name => 'Apple')
    end
    
    should "return an alphabetical list" do
      assert_equal [@apple, @htc, @samsung].map(&:id),
        Brand.alphabetical.map(&:id)
    end
    
    teardown do
      [@htc, @samsung, @apple].map(&:destroy)
    end
  
  end
  
end
