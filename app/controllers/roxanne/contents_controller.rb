module Roxanne
  class ContentsController < ApplicationController

    layout 'application' # from main app
    before_filter :require_login, :except => :show
    before_filter :get_page, :except => :edit

    # GET uri
    def show
     respond_to do |format|
        format.html { render :file => "contents/#{@page.layout}" }
        format.json { render json: @page }
      end
    end

    # GET /edit/uri
    def edit
      session[:edit] = true
      redirect_to main_app.mercury_editor_path(params[:uri])
    end

    # POST uri
    def save
      if params[:content]
        content_ids = params[:content].keys.map{|key| key.gsub("content_", "")}
        contents = Content.find(content_ids)
        contents.each do |content|
          content.text = params[:content]["content_#{content.id}"]["value"]
          content.save! if content.text_changed?
        end
      end
      session[:edit] = false
      respond_to do |format|
        format.html { render nothing: true }
        format.json { render json: Hash.new }
      end
    rescue ActiveRecord::RecordNotFound => rne
      respond_to do |format|
        format.html { render nothing: true }
        format.json { render json: rne.message }
      end
    end

  private

    def get_page
      page  = Page.find_by_uri(params[:uri])
      if page
        @page = PageDecorator.decorate(page)
      else
        redirect_to main_app.root_path, error: "No page found with #{params[:uri]}", :status => 404
      end
    end

  end
end