# -*- encoding : utf-8 -*-
class User < ActiveRecord::Base
  belongs_to :role
  has_many :pages
  has_many :stories
  has_many :comments
  has_secure_password   # also validates password
  attr_accessible :login, :email, :firstname, :lastname, :password, :password_confirmation
  attr_accessible :login, :email, :firstname, :lastname, :password, :password_confirmation, :role_id, :as => :admin
  validates :login, :email, :firstname, :lastname, :presence => true
  validates :login, :email, :uniqueness => true
  validates :email, :format => {:with => /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]+\z/}
end
