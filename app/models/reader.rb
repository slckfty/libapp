class Reader < ActiveRecord::Base
  validates :email, presence: true
  validates :password, presence: true
  validates :email, email: true
  validates :email, uniqueness: true
  validates :password, confirmation: true
  attr_accessor :password, :password_confirmation
end