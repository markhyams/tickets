class Project < ApplicationRecord
  has_many :tickets, dependent: :destroy

  validates :name, presence: true
  validates :description, presence: true

  def self.option_tags
    all.map do |project|
      [project.name, project.id]
    end
  end
end