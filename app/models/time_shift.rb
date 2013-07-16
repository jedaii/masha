class TimeShift < ActiveRecord::Base

	include Authority::Abilities
  self.authorizer_name = 'TimeShiftAuthorizer'

  scope :ordered, -> { order 'date desc, created_at desc' }
  scope :this_day, -> { where ['created_at >= ?', Date.today - 24.hours] }

  belongs_to :project
  belongs_to :user

  validates :project, :presence => true
  validates :user, :presence => true
  validates :date, :timeliness => { :on_or_before => lambda { Date.today }, :type => :date }
  validates :hours, :presence => true, :numericality => { :greater_than_or_equal_to => 0.1, :less_than_or_equal_to => 24 }
  validates :description, :presence => true, :uniqueness => { :scope => [:project_id, :user_id, :date, :hours] }
end
