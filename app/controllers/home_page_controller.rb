# -*- encoding : utf-8 -*-
class HomePageController < ApplicationController 
  skip_before_filter :authorize!

  def index
    @page = Page.first
    
    if params[:locale] == "en"
      @stories = Story.where(:locale_id => Locale.find_by_name("en")).order("created_at DESC")
    else
      @stories = Story.where(:locale_id => Locale.find_by_name("sk")).order("created_at DESC")
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @stories }
    end
  end

end
