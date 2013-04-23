# -*- encoding : utf-8 -*-
class UsersController < ApplicationController
  skip_before_filter :authorize!

  def new
    @user = User.new
    
    respond_to do |format|
      if current_user.nil?
        # create first user with admin rights
        if User.first.nil?
          @role = Role.find_by_name("admin")
        else
          @role = Role.find_by_name("user")
        end
        
        format.html # new.html.erb
        format.json { render json: @user }
      else
        format.html { redirect_to root_path, notice: t(:signed_already) }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def create   
    @role = Role.find_by_name("user")
    @user = User.new(params[:user])
    
    respond_to do |format|
      if @user.save
        format.html { redirect_to root_path, notice: t(:signed_up) }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end 
end
