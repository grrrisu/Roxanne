class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :protected_controllers
end
