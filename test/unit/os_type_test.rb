require 'test_helper'

class OsTypeTest < ActiveSupport::TestCase

  should have_many :os_versions
  should have_many :models
  
  should validate_presence_of :name
  
  should allow_value("ios").for(:name)
  should allow_value("android").for(:name)
  should_not allow_value("").for(:name)
  should_not allow_value(nil).for(:name)

end
