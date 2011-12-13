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
  
  def authorize(options={})
    if current_user.nil?
      redirect_to login_path, :notice => "Please log in!"
      return false
    end

    hero_right     = current_user.role.permissions.where(:hero => true).exists?
    pages_right    = current_user.role.permissions.where(:pages => true).exists?
    stories_right  = current_user.role.permissions.where(:stories => true).exists?
    comments_right = current_user.role.permissions.where(:comments => true).exists?

    # Check rights
    # 1. check section where we are
    # 2. check if we have right to this section
    # 3. check if user is hero -> can edit/destroy all posts
    #                  or he is creating new post (doesn't have id)
    #          else if user is author -> can edit/destroy own post
    # if we have right then return true, else redirect to root_path and return false
    case options[:section]
      when :pages then
        if pages_right
          if hero_right || params[:id].nil? 
            return true
          elsif Page.find(params[:id]).user.id == current_user.id
            return true
          end
        end
      when :stories then
        if stories_right
          if hero_right || params[:id].nil? 
            return true
          elsif Story.find(params[:id]).user.id == current_user.id
            return true
          end
        end
      when :comments then
        if comments_right
          if hero_right || params[:id].nil? 
            return true
          elsif Comment.find(params[:id]).user.id == current_user.id
            return true
          end
        end
    end    
     
    redirect_to root_path, :notice => "You don't have rights!"
    return false
  end
end
