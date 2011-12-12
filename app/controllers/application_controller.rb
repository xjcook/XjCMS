# -*- encoding : utf-8 -*-
class ApplicationController < ActionController::Base
  protect_from_forgery
  helper :all
  helper_method :current_user
  before_filter :set_locale
  
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
    if current_user.nil?
      redirect_to login_path, :notice => "Please log in!"
    end
  end
  
  def check_rights(options={})
    hero = current_user.role.permissions.where(:hero => true).exists?

    case options[:section]
      when :pages then
        if hero 
          return true
        else
          if Page.find_by_id(params[:id]).user.id == current_user.id
            return true
          end
        end
      when :stories then
        if hero 
          return true
        else
          if Story.find_by_id(params[:id]).user.id == current_user.id
            return true
          end
        end
      when :comments then
        if hero 
          return true
        else
          if Comment.find_by_id(params[:id]).user.id == current_user.id
            return true
          end
        end
    end    
     
    redirect_to root_path, :notice => "You don't have rights!"
    return false
  end
end
