Myapp::Application.routes.draw do

  root :to => 'welcome#index'

  namespace :admin do
    root to: "admin#index"
    resources :users
  end

  match 'api/:class' => 'api#call', via: [:get, :post]

end
