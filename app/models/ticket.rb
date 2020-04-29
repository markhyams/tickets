class Ticket < ApplicationRecord
  has_and_belongs_to_many :tags
  ALLOWED_STATUS = ['new', 'blocked', 'in_progress', 'fixed']
  belongs_to :project
  belongs_to :creator, class_name: 'User', foreign_key: 'user_id'
  belongs_to :assignee, class_name: 'User', foreign_key: 'assignee', optional: true
  has_many :comments


  validates :name, presence: true
  validates :body, presence: true
  validates :status, presence: true

  validates :status, acceptance: { accept: ALLOWED_STATUS, message: 'Not a valid ticket status.'}

  def project_name
    Project.find(self.project_id).name
  end

  def self.project_option_tags
    Project.option_tags
  end

  def project_option_tags
    Project.option_tags
  end

  def user_option_tags
    User.option_tags
  end

  def assignee_id
    @assignee ||= self.assignee
    @assignee ? @assignee.id : ""
  end
end