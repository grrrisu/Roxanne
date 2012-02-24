module Roxanne
  class UsersController < ApplicationController
  
    def new
      @user = User.new
    end
  
    def create
      @user = User.new
      @user.username = params[:username]
      @user.email    = params[:email]
      @user.password = params[:password]
      @user.password_confirmation = params[:password_confirmation]
      if @user.save
        redirect_to root_url, :notice => "Successfully created user #{@user.username}"
      else
        render :new
      end
    end
  
  end
end