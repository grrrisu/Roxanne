module Roxanne
  class ApplicationController < ActionController::Base
    before_filter :protected_controllers

    def protected_controllers
      exceptions = [:contents, :sessions]
      require_login unless exceptions.include? controller_name.to_sym
    end
  end
end
