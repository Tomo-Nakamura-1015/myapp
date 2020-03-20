Rails.application.routes.draw do

  root 'top#home'
  get '/about',  to: 'top#about'
  get '/signup',  to: 'users#new'
  post '/signup',  to: 'users#create'

  resources :users

end
