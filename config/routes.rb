Rails.application.routes.draw do
  root to: 'static_pages#home'
  get  '/signup',  to: 'users#new'
  get  '/home',    to: 'static_pages#home'
  get  '/about',   to: 'static_pages#about'
  get  '/help',    to: 'static_pages#help'
  get  '/login',   to: 'static_pages#login'
  get  '/contact', to: 'static_pages#contact'
  post '/signup',  to: 'users#create'
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
