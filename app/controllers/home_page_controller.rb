# -*- encoding : utf-8 -*-
class HomePageController < ApplicationController 

  def index
    @page = Page.first
    @stories = Story.order("created_at DESC").all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @stories }
    end
  end

end
