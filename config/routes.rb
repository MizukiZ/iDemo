Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'authentication#index'
  resources :authentication
  resources :teams
  resources :players

  post '/login', to: 'users#login'
  get '/logout', to: 'users#logout'
end
