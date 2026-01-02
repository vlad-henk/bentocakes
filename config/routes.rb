Rails.application.routes.draw do
  get "carts/show"
  get "carts/update"
  get "carts/destroy"
  root 'pages#home'
  
  get '/about', to: 'pages#about'
  get '/contact', to: 'pages#contact'
  get '/delivery', to: 'pages#delivery'

  resources :products, only: [:index, :show]
  resource :cart, only: [:show, :update, :destroy] do
    member do
      post :add_item
      delete :remove_item
      post :clear
    end
  end
  resources :orders, only: [:new, :create, :show, :index]

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }

  namespace :admin do
    root to: 'dashboard#index'
    resources :products
    resources :orders, only: [:index, :show, :update]
    resources :categories
  end

  get '/search', to: 'products#search'
end
