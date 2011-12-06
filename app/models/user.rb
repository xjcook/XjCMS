class User < ActiveRecord::Base
  belongs_to :role
  attr_accessible :login, :email, :firstname, :lastname, :password, :password_confirmation
  has_secure_password
  validates :login, :password, :presence => true
  validates :login, :uniqueness => true
  validates :password, :length => {:minimum => 5}
end
