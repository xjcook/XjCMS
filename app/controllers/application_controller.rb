# -*- encoding : utf-8 -*-
class ApplicationController < ActionController::Base
  protect_from_forgery
  helper :application
  helper_method :current_user
  before_filter :set_locale
  before_filter :authorize
  
  private
  
  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end
  
  def default_url_options(options={})
    logger.debug "default_url_options is passed options: #{options.inspect}\n"
    { :locale => I18n.locale }
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  
  def authorize
    user = User.find_by_id(session[:user_id])
    
    # check if user is logged
    if user
      # check if user has rights
      
      #hero = user.role.permissions.where(:hero => true).exists?
      
      #if current_page?(:controller => 'user')
      #  if hero 
      #    return true
      #  end
      #elsif current_page?(:controller => 'page')
      #  if hero 
      #    return true
      #  end
      #elsif current_page?(:controller => 'story')
      #  if hero 
      #    return true
      #  end
      #end
      
      #return false
    else
      redirect_to login_path, :notice => "Please log in!"
    end
  end
end
