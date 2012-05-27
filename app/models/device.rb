class Device < ActiveRecord::Base
  attr_accessible :IMEI, :MEID, :active, :condition, :id, :model_id, :os_ver_id
end
