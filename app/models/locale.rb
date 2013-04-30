class Locale < ActiveRecord::Base
  has_many :pages
  has_many :stories
  attr_accessible :name, :language
  validates :name, :presence => true
end
