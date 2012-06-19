FactoryGirl.define do
  
  factory :os_type do
    name          "Android"
  end
  
  factory :os_version do
    association   :os_type
    number        "7"
    name          "Indian Curry"  
  end
  
  factory :brand do
    name          "HTC"
  end
  
  factory :feature do
    name          "Eye Tracking"
  end
  
  factory :model do
    name          "Galaxy S3"
    number        "12345"
    association   :brand
    network_generation :'3G'
    association   :os_type
    screen_size_x_pixels  800
    screen_size_y_pixels  600
  end
  
  factory :model_feature do
    association   :model
    association   :feature
  end
  
  factory :device do
    association   :model
    association   :os_version
    active        true
    IMEI          "49-015420-323751"
    condition     "good"
  end
  
end
