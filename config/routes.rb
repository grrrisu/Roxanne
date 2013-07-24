Roxanne::Engine.routes.draw do
  mount Mercury::Engine => '/' # anything beginning with /editor or /mercury
  put '/', :to => "contents#save", :uri => ''
  root :to => "contents#show", :uri => ''

  get "login", :to => "sessions#new", :as => "login"
  get "logout", :to => "sessions#destroy", :as => "logout"
  post "authenticate", :to => "sessions#create", :as => "authenticate"

  resources :users, :as => 'users'
  resources :pages, :as => 'pages'
  resources :containers, :as => 'containers'
  get 'image_library', :to => "images#index"

  match 'sitemap' => "pages#index", :as => 'sitemap'
  get  '/edit(/*uri)', :to => "contents#edit", :constraints => { :uri => /(?!(editor|mercury)\/).+/ }, :as => "contents_edit"
  get  ':uri', :to => "contents#show", :constraints => { :uri => /(?!(editor|mercury)\/).+/ }
  put ':uri', :to => "contents#save", :constraints => { :uri => /(?!(editor|mercury)\/).+/ }
end

Mercury::Engine.routes.draw do
  namespace :mercury do
    resources :images, only: [:create, :destroy]
  end
end
