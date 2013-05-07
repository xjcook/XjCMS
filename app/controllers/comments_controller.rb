class CommentsController < ApplicationController
  #skip_before_filter :authorize!, :only => :create
  before_filter do |c|
    c.class.module_eval do
    private
      def authorize
        authorize!(:section => :comments)
      end
    end
  end
  
  before_filter :authorize, :except => :create
  
  def create
    logger.debug "-----------Comments#create------------------"
    logger.debug "params[:controller] = " + params[:controller]
    logger.debug "params[:action] = " + params[:action]
    logger.debug "--------------------------------------------"
          
    @story = Story.find(params[:story_id])
    @comment = @story.comments.create(params[:comment])
    
    respond_to do |format|
      format.html { redirect_to @story, notice: t(:comment_created) }
      format.json { render json: @story, status: :created, location: @comment }
    end
  end
  
  def destroy
    logger.debug "-----------Comments#destroy-----------------"
    logger.debug "params[:controller] = " + params[:controller]
    logger.debug "params[:action] = " + params[:action]
    logger.debug "--------------------------------------------"
    
    @story = Story.find(params[:story_id])
    @comment = @story.comments.find(params[:id])
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to @story, notice: t(:comment_deleted) }
      format.json { render json: @story, status: :deleted }
    end
  end
end
