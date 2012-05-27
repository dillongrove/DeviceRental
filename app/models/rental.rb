class Rental < ActiveRecord::Base
  attr_accessible :date_requested, :device_id, :end_date, :id, :stage, :start_date, :user_id
end
