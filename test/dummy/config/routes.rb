Rails.application.routes.draw do
  Roxanne::Engine.routes
  root :to => "contents#show", :uri => ''
end
