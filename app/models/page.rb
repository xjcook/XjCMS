# -*- encoding : utf-8 -*-
class Page < ActiveRecord::Base
  belongs_to :user
  validates :title, :content, :user_id, :presence => true
end
