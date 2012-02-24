require 'mercury-rails'
require 'ancestry'
require 'draper'
require 'sorcery'
require 'haml'
require 'formtastic'

module Roxanne
  class Engine < ::Rails::Engine
    isolate_namespace Roxanne
    
    def self.routes
      Rails.application.routes.draw do
        scope :module => 'roxanne' do
          post '/', :to => "contents#save", :uri => ''
          root :to => "contents#show", :uri => ''
        end

        Mercury::Engine.routes

        scope :module => 'roxanne' do
          get "login", :to => "sessions#new", :as => "login"
          get "logout", :to => "sessions#destroy", :as => "logout"
          post "authenticate", :to => "sessions#create", :as => "authenticate"

          resources :users
          resources :pages
          resources :containers
          resources :images, :only => :index

          match 'sitemap' => "pages#index"
          get  '/edit(/*uri)', :to => "contents#edit", :constraints => { :uri => /(?!(editor|mercury)\/).+/ }, :as => "contents_edit"
          get  ':uri', :to => "contents#show", :constraints => { :uri => /(?!(editor|mercury)\/).+/ }
          post ':uri', :to => "contents#save", :constraints => { :uri => /(?!(editor|mercury)\/).+/ }
        end
      end 
    end
  end
end
