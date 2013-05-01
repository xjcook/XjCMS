class CommentsController < ApplicationController
  skip_before_filter :authorize!
  
  def create
    @story = Story.find(params[:story_id])
    @comment = @story.comments.create(params[:comment])
    redirect_to stories_path(@story)
  end
end
