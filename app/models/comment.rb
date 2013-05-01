class Comment < ActiveRecord::Base
  belongs_to :story
  belongs_to :user
  attr_accessible :author, :body, :story_id, :user_id
  validates :body, :story_id, :presence => true
end
