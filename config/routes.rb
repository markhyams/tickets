Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'projects#index'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'
  get '/register', to: 'users#new'

  
  resources :users, only: [:create]
  resources :projects
  resources :tickets do
    resources :comments, only: [:create, :edit, :update]
  end
  resources :comments, only: [:destroy]
  resources :tags
end
