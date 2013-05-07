class CommentsController < ApplicationController
  skip_before_filter :authorize!
  
  def create
    @story = Story.find(params[:story_id])
    @comment = @story.comments.create(params[:comment])
    
    respond_to do |format|
      format.html { redirect_to @story, notice: t(:comment_created) }
      format.json { render json: @story, status: :created, location: @comment }
    end
  end
end
