class User < ActiveRecord::Base
  belongs_to :role
  has_many :pages
  has_many :stories
  has_secure_password
  attr_accessible :login, :email, :firstname, :lastname, :password, :password_confirmation, :role
  validates :login, :password, :role_id, :presence => true
  validates :login, :uniqueness => true
  validates :password, :length => {:minimum => 4}
end
