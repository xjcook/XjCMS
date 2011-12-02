class ApplicationController < ActionController::Base
  protect_from_forgery
  
  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  
  def authenticate_user!
    if session[:user_id].nil?
      redirect_to login_path, :notice => "Please login!"
    end
    
    #if current_user.nil?
    #  redirect_to login_url, :alert => "You must first log in to access this page"
    #end
  end
  
  helper_method :current_user
end
