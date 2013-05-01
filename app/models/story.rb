# -*- encoding : utf-8 -*-
class Story < ActiveRecord::Base
  belongs_to :user
  belongs_to :locale
  has_many :comments
  validates :title, :content, :user_id, :locale_id, :presence => true
end
