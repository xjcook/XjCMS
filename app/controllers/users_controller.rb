# -*- encoding : utf-8 -*-
class UsersController < ApplicationController
  skip_before_filter :authorize

  def new
    @user = User.new
  end

  def create
    if User.first.nil?
      @role = Role.find_by_name("admin")
    else
      @role = Role.find_by_name("user")
    end
    
    @user = User.new(params[:user])
    
    if @user.save
      redirect_to root_url, :notice => "Signed up!"
    else
      render "new"
    end
  end 
end
