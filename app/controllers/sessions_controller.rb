# -*- encoding : utf-8 -*-
class SessionsController < ApplicationController
  # TODO respond_to

  def new
  end

  def create
    user = User.find_by_login(params[:login])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      
      if session[:redirect_back].nil?
        redirect_to root_url, :notice => "Logged in!"
      else
        redirect_to session[:redirect_back], :notice => "Logged in!"
      end
    else
      flash.now.alert = "Invalid email or password"
      render "new"
    end
  end

  def destroy
    session[:user_id] = nil
    session[:redirect_back] = nil
    redirect_to root_url, :notice => "Logged out!"
  end
end
