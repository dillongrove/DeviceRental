# Rental Record
#
# Every rental has created_at, requested_date, loan_date, end_date, return_date, and approve_date
#    created_at:      when this record was created (i.e. when the user used this website)
#    requested_date:  the user says, "I intend to start on this date"
#    approve_date:    when this rental was approved
#    loan_date:       the actual date we loaned it to him
#    end_date:        the user says, "I intend to return on this date"
#    return_date:     the actual date it was returned to us
class Rental < ActiveRecord::Base

  attr_accessible :id, :user_id, :device_id, :created_at, :requested_date, :loan_date, :end_date, :return_date, :approve_date
  
  # Relationships --------------------------------------------------------------
  belongs_to :user
  belongs_to :device
  
  # Scopes ---------------------------------------------------------------------
  
  # filter by device id, and user id
  scope :for_device, lambda { |device_id| where('device_id = ?', device_id) }
  scope :for_user, lambda { |user_id| where('user_id = ?', user_id) }
  
  # sort by andrew id
  scope :by_user, joins(:user).order(:andrew)
  
  # sort by model name
  scope :by_device, joins(:device).joins(:model).order('models.name')
  
  # Validations ----------------------------------------------------------------
  # Callbacks ------------------------------------------------------------------
  
  alias :old_to_s :to_s
  # string representation of this rental
  def to_s
    "#{self.user} w. #{self.device}"
  end
  
end
