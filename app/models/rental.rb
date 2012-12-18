# Rental Record
#
# Every rental has created_at, requested_date, loan_date, end_date, return_date, and approve_date
#    created_at:      when this record was created (i.e. when the user used this website)
#    approve_date:    when this rental was approved
#    loan_date:       the actual date we loaned it to him
#    end_date:        the user says, "I intend to return on this date"
#    return_date:     the actual date it was returned to us
#
# created_at <= approve_date <= requested/loan_date <= loan/requested_date <= end/return_date <= end/return_date
class Rental < ActiveRecord::Base

  attr_accessible :id, :user_id, :device_id, :created_at,
                  :loan_date, :end_date,
                  :return_date, :approve_date
  
  # Relationships --------------------------------------------------------------
  belongs_to :user
  belongs_to :device
  
  # Scopes ---------------------------------------------------------------------
  
  # filter by device id, and user id
  scope :for_device, lambda { |device_id| where('device_id = ?', device_id) }
  scope :for_user, lambda { |user_id| where('user_id = ?', user_id) }
  
  # sort by model name, andrew id
  scope :by_device, joins(:device).joins(:model).order('models.name')
  scope :by_user, joins(:user).order(:andrew)
  
  # sort by requested_date
  scope :chronological, order(:loan_date)
  
  # upcoming rentals -> requested_date is coming up within n days, and loan_date is nil
  scope :upcoming_for_n_days, lambda { |n|
    where('loan_date IS NIL AND requested_date BETWEEN ? AND ?',
          Date.current, n.days.from_now.to_date)
  }
  
  # due rentals -> end_date is coming up within n days, and return_date is nil
  scope :due_for_n_days, lambda { |n|
    where('return_date IS NIL AND end_date BETWEEN ? AND ?',
          Date.current, n.days.from_now.to_date)
  }
  
  # late rentals -> end_date has past and return date is nil
  scope :late, lambda {
    where('return_date IS NIL AND end_date < ?', Date.current)
  }
  
  # Validations ----------------------------------------------------------------
  
  # there must always be at least a user ID, device ID, and intended start/end dates
  validates_presence_of :user_id, :device_id
  validate :user_must_exist
  validate :device_must_exist
  
  # end date must be after requested date
  validates_date :end_date,
    :on_or_after => :created_at,
    :on_or_after_message => 'must be on or after the requested date'
  
  # approve_date is optional, must be after created date  
  validates_date :approve_date,
    :allow_nil => true,
    :on_or_after => :created_at,
    :on_or_after_message => 'must be on or after the date this request was made' 
    
  # loan_date is optional, must be after approve_date
  validates_date :loan_date,
    :allow_nil => true,
    :on_or_after => :approve_date,
    :on_or_after_message => 'must be on or after the approval date'
    
  # return_date is optional, must be after loan date
  validates_date :return_date,
    :allow_nil => true,
    :on_or_after => :loan_date,
    :on_or_after_message => 'must be on or after the loan date'
  
  # Callbacks ------------------------------------------------------------------
  
  # Methods --------------------------------------------------------------------
  
  # Current stage of the rental
  #  :created | :approved | :loaned | :returned
  def stage
    return :returned  if (not self.return_date.nil?) && (self.return_date.to_date <= Date.current)
    return :loaned    if (not self.loan_date.nil?) && (self.loan_date.to_date <= Date.current)
    return :approved  if (not self.approve_date.nil?) && (self.approve_date.to_date <= Date.current)
    return :created   if (not self.created_at.nil?)
    return :undefined # probably should never reach here
  end
  
  alias :old_to_s :to_s
  # string representation of this rental
  def to_s
    "#{self.user} - #{self.device.model.name}"
  end
  
  private
  
  # checks that the associated user exists
  def user_must_exist
    return if self.user_id.nil?
    errors.add(:user_id, "must be a registered user") if User.find(self.user_id).nil?
  end
  
  # checks that the associated device exists
  def device_must_exist
    return if self.device_id.nil?
    errors.add(:device_id, "must be an existing device") if Device.find(self.device_id).nil?
  end
  
end
