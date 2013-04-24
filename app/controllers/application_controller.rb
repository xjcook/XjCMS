# -*- encoding : utf-8 -*-
class ApplicationController < ActionController::Base
  protect_from_forgery
  helper :all
  helper_method :current_user
  helper_method :has_right?
  helper_method :is_hero?
  before_filter :set_locale
  before_filter :authorize!
  
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
  
  def authorize!
    if has_right?
      return true
    else
      if current_user.nil?
        session[:redirect_back] = url_for(:only_path => false)
        redirect_to login_path, :notice => t(:please_login)
        return false
      else
        session[:redirect_back] = nil
        redirect_to root_path, :notice => t(:wrong_rights)
        return false
      end
    end
  end
  
  def has_right?(options={})
    if current_user.nil?
      return false
    else
      # Check rights
      # 1. check section where we are
      # 2. check if we have right to this section
      # 3. check if user is hero -> can edit/destroy all posts
      #                  or he is creating new post (doesn't have id)
      #          else if user is author -> can edit/destroy own post
      # if we have right then return true, else redirect to root_path and return false
      
      # set post id
      if !params[:id].nil? 
        id = params[:id]
      elsif !options[:id].nil?
        id = options[:id]
      else
        id = nil
      end
      
      # if user is hero can edit foreign posts
      hero_right = current_user.role.permissions.where(:hero => true).exists?
      
      case params[:controller]
        when "pages"
          pages_right = current_user.role.permissions.where(:pages => true).exists?
          
          if pages_right
            if hero_right || id.nil? 
              return true
            elsif Page.find(id).user.id == current_user.id
              return true
            end
          end
        when "stories"
          stories_right = current_user.role.permissions.where(:stories => true).exists?
          
          if stories_right
            if hero_right || id.nil?
              return true
            elsif Story.find(id).user.id == current_user.id
              return true
            end
          end
        when "comments"
          comments_right = current_user.role.permissions.where(:comments => true).exists?
          
          if comments_right
            if hero_right || id.nil? 
              return true
            elsif Comment.find(id).user.id == current_user.id
              return true
            end
          end
        when "users" # TODO users_right
          if hero_right 
            return true
          elsif id != nil && User.find(id).id == current_user.id
            return true
          end
      else
        return false
      end 
    end
  end
  
  def is_hero?
    if current_user.nil?
      return false
    else
      hero_right = current_user.role.permissions.where(:hero => true).exists?
      
      if hero_right 
        return true
      else
        return false
      end
    end
  end
end
