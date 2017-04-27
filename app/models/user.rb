class User < ApplicationRecord
  include Clearance::User


  validates :username, format: { without: /\s/, message: "must contain no spaces" }
  validates :username, uniqueness: true
  validates :username, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/, message: "Only valid email allowed."}
  validates :password, length: 8..20
end

