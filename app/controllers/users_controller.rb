class UsersController < ApplicationController
  skip_before_filter :authorize

  def new
    @user = User.new
  end

  def create
#if User.first
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
