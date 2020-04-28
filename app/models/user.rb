class User < ApplicationRecord
  has_many :tickets
  has_many :comments

  validates :username, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password_digest, presence: true
  has_secure_password

  def self.option_tags
    all.map do |user|
      [user.username, user.id]
    end
  end

end