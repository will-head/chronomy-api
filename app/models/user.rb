class User < ApplicationRecord
  has_secure_password

  validates_presence_of :email, :username
  validates_uniqueness_of :email, :username
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, length: { minimum: 6 }
end
