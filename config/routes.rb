Myapp::Application.routes.draw do
  get "welcome/index"

  root :to => 'welcome#index'

  match 'api/:class' => 'api#call', via: [:get, :post]

end
