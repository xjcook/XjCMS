# -*- encoding : utf-8 -*-
class UsersController < ApplicationController
  skip_before_filter :authorize

  def new
    @role = Role.find_by_name("user")
    @user = User.new
  end

  def create
#if User.first
    @role = Role.find_by_name("user")
    @user = User.new(params[:user])
#@user.role_id = 2 # normal user
#else
#@user = User.new(params[:user])
#@user.role_id = 1 # administrator
#end
    
    if @user.save
      redirect_to root_url, :notice => "Signed up!"
    else
      render "new"
    end
  end 
end
