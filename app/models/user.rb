# -*- encoding : utf-8 -*-
class User < ActiveRecord::Base
  belongs_to :role
  has_many :pages
  has_many :stories
  has_secure_password
  attr_accessible :login, :email, :firstname, :lastname, :password, :password_confirmation, :role, :role_id
  validates :login, :password, :email, :firstname, :lastname, :role_id, :presence => true
  validates :login, :uniqueness => true
  validates :password, :length => {:minimum => 4}
  validates :email, :format => {:with => /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]+\z/}
end
