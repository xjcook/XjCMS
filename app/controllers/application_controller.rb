# -*- encoding : utf-8 -*-
class ApplicationController < ActionController::Base
  protect_from_forgery
  helper :all
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
    if current_user
      # check if user has rights      
      hero = current_user.role.permissions.where(:hero => true).exists?
      
      # ... ?
      # ALGORITMUS
      # - musime vediet kde sa nachadza
      # - ak je hero, tak staci aby sa nachadzal v prislusnom controlleri
      # - ak nie je, tak overime ci ma na action pravo t.j. post musi patrit jemu
      # - aj ked nie je, ma pravo vytvarat nove posty
      # IMPLEMENTACIA
      # - do kazdeho controlleru supnut novu autorizacnu metodu
    else
      redirect_to login_path, :notice => "Please log in!"
    end
  end
end
