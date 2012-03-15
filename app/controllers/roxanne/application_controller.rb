module Roxanne
  class ApplicationController < ActionController::Base
    
    def protected_controllers
      exceptions = [:contents, :sessions]
      require_login unless exceptions.include? controller_name.to_sym
    end
    
    # callback function for sorcery if require_login fails
    def not_authenticated
      redirect_to main_app.root_path
    end
    
  end
end
