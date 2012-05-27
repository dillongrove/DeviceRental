class OsVersion < ActiveRecord::Base
  attr_accessible :id, :name, :number, :os_type_id
end
