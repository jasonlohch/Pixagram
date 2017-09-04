Rails.application.routes.draw do
  resources :users
  resources :sessions, only: [:new, :create, :destroy]
  root 'welcome#index'
  match '/sign_up', to: 'users#new', via: 'get'
  match '/sign_in',  to: 'sessions#new',         via: 'get'
  match '/sign_out', to: 'sessions#destroy',     via: 'delete'
end
