module Roxanne
  class ImagesController < ApplicationController
  
    def index
      @images = Mercury::Image.all
      render :index, :layout => false
    end
  
    def select
      @image = Mercury::Image.find params[:id]
    end

  end
end