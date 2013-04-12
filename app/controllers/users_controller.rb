# -*- encoding : utf-8 -*-
class UsersController < ApplicationController
  skip_before_filter :authorize!
  # TODO respond_to

  def new
    if current_user.nil?
      if User.first.nil?
        @role = Role.find_by_name("admin")
      else
        @role = Role.find_by_name("user")
      end
      @user = User.new
    elsif
      redirect_to root_path, :notice => "You are already signed!"
    end
  end

  def create   
    # TODO security hole - can modify RoleID
    @role = Role.find(params[:user][:role_id])
    @user = User.new(params[:user])
    
    if @user.save
      redirect_to root_path, :notice => "Signed up!"
    else
      render "new"
    end
  end 
end
