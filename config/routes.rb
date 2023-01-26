Rails.application.routes.draw do
  resources :sessions, only: [:new, :create, :destroy]
  resources :tasks
  root to: 'tasks#index'
  resources :users
  namespace :admin do
    resources :users
  end
end
