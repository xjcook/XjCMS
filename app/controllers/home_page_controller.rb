# -*- encoding : utf-8 -*-
class HomePageController < ApplicationController 
  #skip_before_filter :authorize!

  def index
    if params[:locale] == "en"
      @page = Page.where(:locale_id => Locale.find_by_name("en")).first
      @stories = Story.where(:locale_id => Locale.find_by_name("en")).order("created_at DESC")
    else
      @page = Page.where(:locale_id => Locale.find_by_name("sk")).first
      @stories = Story.where(:locale_id => Locale.find_by_name("sk")).order("created_at DESC")
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @stories }
    end
  end

end
