# -*- encoding : utf-8 -*-
class UsersController < ApplicationController
  # TODO respond_to

  def new
    if User.first.nil?
      @role = Role.find_by_name("admin")
    else
      @role = Role.find_by_name("user")
    end
    
    @user = User.new
  end

  def create   
    @user = User.new(params[:user])
    @role = Role.find(params[:user][:role_id])
    
    if @user.save
      redirect_to root_url, :notice => "Signed up!"
    else
      render "new"
    end
  end 
end
