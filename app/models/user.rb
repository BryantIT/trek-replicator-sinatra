class User < ActiveRecord::Base
  has_secure_password
  has_many :recipes

  validates :username, uniqueness: true
  validates :username, presence: true
  validates :password, presence: true
end
