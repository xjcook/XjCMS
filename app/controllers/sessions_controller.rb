# -*- encoding : utf-8 -*-
class SessionsController < ApplicationController
  skip_before_filter :authorize!

  def new
    respond_to do |format|
      format.html # new.html.erb
      format.json { head :ok }
    end
  end

  # TODO respond_to
  def create
    user = User.find_by_login(params[:login])
    
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      
      # redirect to previous page
      if session[:redirect_back].nil?
        #redirect_to :back, :notice => t(:logged_in)
        redirect_to root_path, :notice => t(:logged_in)
      else
        redirect_to session[:redirect_back], :notice => t(:logged_in)
      end
    else
      flash[:notice] = t(:invalid_login)
      render "new"
    end
  end

  # TODO respond_to
  def destroy
    session[:user_id] = nil
    session[:redirect_back] = nil
    redirect_to root_url, :notice => t(:logged_out)
  end
end
