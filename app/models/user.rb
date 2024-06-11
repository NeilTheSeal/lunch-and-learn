class User < ApplicationRecord
  validates :email, uniqueness: true, presence: true
  validates :api_key, uniqueness: true
  validates_presence_of :password, :name

  has_secure_password
end
