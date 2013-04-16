module Roxanne
  class ContainersController < ApplicationController

    # GET /containers
    # GET /containers.json
    def index
      @containers = Container.all

      respond_to do |format|
        format.html # index.html.erb
        format.json { render json: @containers }
      end
    end

    # GET /containers/1
    # GET /containers/1.json
    def show
      @container = Container.find(params[:id])

      respond_to do |format|
        format.html # show.html.erb
        format.json { render json: @container }
      end
    end

    # GET /containers/new
    # GET /containers/new.json
    def new
      if params[:sibling_id]
        @container = Container.new
        @container.sibling_id = params[:sibling_id]
      elsif params[:parent_id]
        parent  = Container.find params[:parent_id]
        @container = Container.new :parent => parent
      else
        page = Page.find params[:page_id]
        @container = ContainerList.new :page => page, :name => params[:name]
      end

      respond_to do |format|
        format.html { render partial: 'form' }
        format.json { render json: @container }
      end
    end

    # GET /containers/1/edit
    def edit
      @container = Container.find(params[:id])
    end

    # POST /containers.js
    def create
      if params[:container_list].present?
        @container = ContainerList.new(params[:container_list].merge(:template => params[:container_list][:list]))
      else
        @container = Container.new(params[:container])
      end

      respond_to do |format|
        if @container.save
          format.html { redirect_to roxanne.container_path(@container), notice: 'Container was successfully created.' }
          format.json { render json: @container, status: :created, location: @container }
          format.js   { render text: ContainerDecorator.decorate(@container).render }
        else
          format.html { render action: "new" }
          format.json { render json: @container.errors, status: :unprocessable_entity }
          format.js   { render text: @container.errors, status: :error }
        end
      end
    end

    # PUT /containers/1
    # PUT /containers/1.json
    def update
      @container = Container.find(params[:id])

      respond_to do |format|
        if @container.update_attributes(params[:container])
          format.html { redirect_to @container, notice: 'Container was successfully updated.' }
          format.json { head :ok }
        else
          format.html { render action: "edit" }
          format.json { render json: @container.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /containers/1
    # DELETE /containers/1.json
    def destroy
      @container = Container.find(params[:id])
      @container.destroy

      respond_to do |format|
        format.html { redirect_to containers_url }
        format.json { head :ok }
      end
    end
  end
end
