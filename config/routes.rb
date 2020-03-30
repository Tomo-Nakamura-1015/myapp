Rails.application.routes.draw do

  get 'sessions/new'
  root 'top#home'
  get '/about',      to: 'top#about'
  get '/signup',     to: 'users#new'
  post '/signup',    to: 'users#create'
  get '/login',      to: 'sessions#new'
  post '/login',     to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  get '/search',     to: 'search#search'
  get '/followers',  to: 'relationships#followers'
  get '/followings', to: 'relationships#followings'

  resources :relationships, only: [:create, :destroy]
  resources :users
  resources :posts

end
