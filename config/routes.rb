Rails.application.routes.draw do
  get 'password_resets/new'
  get 'password_resets/edit'
  root to: 'static_pages#home'
  get  '/signup',               to: 'users#new'
  get  '/home',                 to: 'static_pages#home'
  get  '/about',                to: 'static_pages#about'
  get  '/help',                 to: 'static_pages#help'
  get  '/contact',              to: 'static_pages#contact'
  get  '/login',                to: 'sessions#new'
  post '/signup',               to: 'users#create'
  post '/login',                to: 'sessions#create'
  delete '/logout',             to: 'sessions#destroy'
  get  '/activate_user/:token', to: 'account_activations#edit', as: 'account_activation'
  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :relationships,   only: [:create, :destroy]
  resources :password_resets, only: [:new, :create, :edit, :update]
  resources :users
  resources :microposts,      only: [:create, :destroy]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
