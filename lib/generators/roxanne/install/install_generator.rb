module Roxanne
  class InstallGenerator < Rails::Generators::Base
    source_root File.expand_path("../templates", __FILE__)

    desc "include javascript and stylesheets for roxanne"
    def add_assets
      append_to_file "app/assets/javascripts/application.js", "//= require roxanne/application\n"
      insert_into_file "app/assets/stylesheets/application.css", " *= require 'roxanne/roxanne'\n", :before => '*/'
      insert_into_file "app/assets/stylesheets/application.css", " *= require 'roxanne/toolbar'\n", :before => '*/'
    end

    desc "enables authentication"
    def add_authentication
      copy_file "sorcery.rb", "config/initializers/sorcery.rb"
      insert_into_file "app/controllers/application_controller.rb", "  before_filter :protected_controllers\n", :before => "end"
    end

    desc "prepare views"
    def prepare_views
      remove_file "app/views/layouts/application.html.erb"
      copy_file "application.html.haml", "app/views/layouts/application.html.haml"
      copy_file "mercury.html.erb", "app/views/layouts/mercury.html.erb"
      directory "contents", "app/views/contents/"
      directory "pages", "app/views/pages/"
      empty_directory "app/views/templates"
      empty_directory "app/views/templates/snippets"
      empty_directory "app/views/templates/sections"
      empty_directory "app/views/templates/lists"
    end

    desc "add Roxanne routes"
    def mount
      route "mount Roxanne::Engine => '/roxanne'"
    end

    desc "migrate database"
    def migrate_database
      rake "roxanne:install:migrations"
    	rake "db:migrate"
    end

    desc "load seeds"
    def load_seeds
      rake "roxanne:seed"
    end

    desc "remove defaults"
    def remove_defaults
      remove_file 'public/index.html'
      remove_file 'app/assets/images/rails.png'
    end

  end
end