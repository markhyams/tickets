class Ticket < ApplicationRecord
  ALLOWED_STATUS = ['new', 'blocked', 'in_progress', 'fixed']
  belongs_to :project

  validates :name, presence: true
  validates :body, presence: true
  validates :status, presence: true

  validates :status, acceptance: { accept: ALLOWED_STATUS, message: 'Not a valid ticket status.'}

  def project_option_tags
    Project.option_tags
  end
end