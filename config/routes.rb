Rails.application.routes.draw do
  scope :module => 'roxanne' do
    post '/', :to => "contents#save", :uri => ''
    root :to => "contents#show", :uri => ''
  end

  mount Mercury::Engine => '/'

  scope :module => 'roxanne' do
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
    post ':uri', :to => "contents#save", :constraints => { :uri => /(?!(editor|mercury)\/).+/ }
  end
end