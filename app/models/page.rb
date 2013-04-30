# -*- encoding : utf-8 -*-
class Page < ActiveRecord::Base
  belongs_to :user
  belongs_to :locale
  validates :title, :content, :user_id, :locale_id, :presence => true
end
