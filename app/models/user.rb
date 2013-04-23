# -*- encoding : utf-8 -*-
class User < ActiveRecord::Base
  belongs_to :role
  has_many :pages
  has_many :stories
  has_secure_password
  attr_accessible :login, :email, :firstname, :lastname, :password, :password_confirmation
  validates :login, :email, :firstname, :lastname, :password, :password_confirmation, :presence => true
  validates :login, :email, :uniqueness => true
  validates :password, :length => {:minimum => 4, :maximum => 40}
  validates :email, :format => {:with => /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]+\z/}
end
