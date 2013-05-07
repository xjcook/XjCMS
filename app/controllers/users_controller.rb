# -*- encoding : utf-8 -*-
class UsersController < ApplicationController
  #skip_before_filter :authorize!, :only => [:new, :create]
  before_filter do |c|
    c.class.module_eval do
    private
      def authorize
        authorize!(:section => :users)
      end
    end
  end
  
  before_filter :authorize, :except => [:new, :create]
  
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
    respond_to do |format|
      if current_user.nil?
        @user = User.new
        
        # TODO Assign to first user administrator role
        # create first user with admin rights
        #if User.first.nil?
        #  @user.role = Role.find_by_name("admin")
        #else
        #  @user.role = Role.find_by_name("user")
        #end
        
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
    @user = User.new(params[:user])
    @user.role = Role.find_by_name("user")
    
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
    if params[:user][:password].blank? && params[:user][:password_confirmation].blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end
     
    @user = User.find(params[:id])

    respond_to do |format|
      if is_admin?
        if @user.update_attributes(params[:user], :as => :admin)
          format.html { redirect_to @user, notice: t(:user_updated) }
          format.json { head :ok }
        else
          format.html { render action: "edit" }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end 
      else
        if @user.update_attributes(params[:user])
          format.html { redirect_to @user, notice: t(:user_updated) }
          format.json { head :ok }
        else
          format.html { render action: "edit" }
          format.json { render json: @user.errors, status: :unprocessable_entity } 
        end
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
