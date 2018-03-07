Rails.application.routes.draw do
  get "password_resets/new"
  get "password_resets/edit"
  get "sessions/new"
  get "users/new"
  root "static_pages#home"
  get "/help", to: "static_pages#help"
  get "/about", to: "static_pages#about"
  get "/contact", to: "static_pages#contact"
  get "/signup", to: "users#new"
  post "/signup", to: "users#creat"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  get "/logout", to: "sessions#destroy"
  resources :users
  resources :account_activation, only: [:edit]
  resources :password_resets, except: [:index, :show, :destroy]
end
