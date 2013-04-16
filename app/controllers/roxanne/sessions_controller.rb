module Roxanne
  class SessionsController < ApplicationController

    def new
    end

    def create
      user = login(params[:session][:username], params[:session][:password], params[:session][:remember_me])
      if user
        redirect_back_or_to roxanne.root_url, :notice => "Logged in"
      else
        flash[:error] = "Login failed"
        render :action => 'new'
      end
    end

    def destroy
      logout
      redirect_to roxanne.root_url, :notice => "Logged out"
    end

  end
end
