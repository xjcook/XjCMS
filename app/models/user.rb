class User < ActiveRecord::Base
  belongs_to :role
  attr_accessible :login, :email, :firstname, :lastname, :password, :password_confirmation, :role
  has_secure_password
  validates :login, :password, :role_id, :presence => true
  validates :login, :uniqueness => true
  validates :password, :length => {:minimum => 4}
  validates :role_id, :numericality => true
end
