Rails.application.routes.draw do

  
  root 'top#home'
  get 'sessions/new'
  get '/about',      to: 'top#about'
  get '/contact',    to: 'top#contact'
  get '/signup',     to: 'users#new'
  post '/signup',    to: 'users#create'
  get '/login',      to: 'sessions#new'
  post '/login',     to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  get '/search',     to: 'search#search'
  get '/followers',  to: 'relationships#followers'
  get '/followings', to: 'relationships#followings'

  resources :users do
    member do
     get :following, :followers
    end
  end

  resources :relationships, only: [:create, :destroy]
  resources :posts

end
