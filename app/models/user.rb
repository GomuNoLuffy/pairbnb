class User < ApplicationRecord
  include Clearance::User


  # validates :username, format: { without: /\s/, message: "must contain no spaces" }
  # validates :username, uniqueness: true
  # validates :username, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/, message: "Only valid email allowed."}
  # validates :password, length: 8..20

  has_many :authentications, :dependent => :destroy
  has_many :listings, :dependent => :destroy

  @@login = false 

  def self.create_with_auth_and_hash(authentication, auth_hash)
      @@login = true
      user = User.create!(first_name: auth_hash["info"]["first_name"], last_name: auth_hash["info"]["last_name"], email: auth_hash["extra"]["raw_info"]["email"])
      user.authentications << (authentication)      
      return user
  end

  def fb_token
    x = self.authentications.where(:provider => :facebook).first
    return x.token unless x.nil?
  end

  def password_optional?
    if @@login 
      return true 
    else 
      return false
    end 
      @@login = false 
  end


end

