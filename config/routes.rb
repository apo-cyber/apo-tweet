Rails.application.routes.draw do
  namespace :admin do
    get 'users/index'
    get 'users/show'
    get 'users/new'
    get 'users/edit'
  end
  resources :users
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  resources :posts do
    resources :likes, only: [:create, :destroy]
  end

  root 'home#top'
  get '/about', to: 'home#about'

end
