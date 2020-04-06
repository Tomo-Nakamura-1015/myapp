Rails.application.routes.draw do

  root 'top#home'

  get '/about',      to: 'top#about'
  get '/contact',   to: 'contacts#new'
  post '/contact',   to: 'contacts#create'
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

  resources :posts do
    resources :likes, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy]
  end

end