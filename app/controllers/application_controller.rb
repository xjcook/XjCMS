class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :set_locale
  before_filter :authorize
  
  private
 
  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def current_user
    @current_user ||= User.find_by_id(session[:user_id]) if session[:user_id]
  end
  
  def authorize
    # check if user is logged
    unless User.find_by_id(session[:user_id])
      redirect_to login_path, :notice => "Please log in!"
    end

    # check if user has rights
#@current_user.role.permissions:q

  end
  
  helper_method :current_user
end
