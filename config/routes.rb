Rails.application.routes.draw do
  get "orders/index"
  get "orders/show"
  get "orders/new"
  get "orders/create"
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
    get "orders/index"
    get "orders/show"
    get "orders/update"
    get "products/index"
    get "products/show"
    get "products/new"
    get "products/create"
    get "products/edit"
    get "products/update"
    get "products/destroy"
    get "dashboard/index"
    root to: 'dashboard#index'
    resources :products do
      member do
        patch :activate
        patch :deactivate
      end
    end
    resources :orders, only: [:index, :show, :update]
    resources :categories
  end

  get '/search', to: 'products#search'
end
