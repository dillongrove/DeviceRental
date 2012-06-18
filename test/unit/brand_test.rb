require 'test_helper'

class BrandTest < ActiveSupport::TestCase
  
  should have_many :models
  should have_many(:devices).through(:models)
  
  should validate_presence_of :name
  
  should allow_value("samsung").for(:name)
  should allow_value("htc").for(:name)
  should_not allow_value("").for(:name)
  should_not allow_value(nil).for(:name)
  
end
