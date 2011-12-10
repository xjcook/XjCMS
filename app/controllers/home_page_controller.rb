# -*- encoding : utf-8 -*-
class HomePageController < ApplicationController
  skip_before_filter :authorize  

  def index
    @page = Page.first
    @stories = Story.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @stories }
    end
  end

end
