Myapp::Application.routes.draw do

  root :to => 'splash#index'

  namespace :admin do
    root to: "admin#index"
    resources :users
  end

  match 'user/:action', to: 'user#:action', via: [:get]
  match 'list/:action', to: 'list#:action', via: [:get]

  match 'api/:class' => 'api#call', via: [:get, :post]
  match 'signup' => 'splash#signup', via: [:get, :post]
  match 'logout', to: 'session#destroy', via: [:get, :post]
  match 'login', to: 'session#create_by_email', via: [:get, :post]

end
