Rails.application.routes.draw do

  resources :posts do
  	resources :comments, only: [:create]
  end

  resources :comments, only: [:destroy]

  resources :users
  resources :sessions, only: [:new, :create, :destroy]
  root 'posts#index'
  get '/sign_up', to: 'users#new'
  get '/sign_in',  to: 'sessions#new'
  delete '/sign_out', to: 'sessions#destroy'
  get "/auth/:provider/callback" => "sessions#create_from_omniauth"
  get 'posts/location', to: 'posts#location'
end
