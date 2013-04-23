# -*- encoding : utf-8 -*-
class UsersController < ApplicationController
  skip_before_filter :authorize!, :only => [:new, :create]
  
  def index
    @users = User.all
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end
  
  def show
    @user = User.find(params[:id])
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end
  
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
        format.json { render json: t(:signed_already), status: :unprocessable_entity }
      end
    end
  end
  
  def edit
    @user = User.find(params[:id])
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
  
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, notice: t(:user_updated) }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :ok }
    end
  end 
end
