Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root 'projects#index'

  resources :projects
  resources :tickets
  resources :tags, except: [:show]
end
