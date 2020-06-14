Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  devise_scope :user do
    authenticated :user do
      root 'posts#index', as: :authenticated_root
    end
  
    unauthenticated do
      root 'devise/sessions#new', as: :unauthenticated_root
    end
  end

  resources :users, only: [:index, :show, :friend_request, :befriend, :notifications, :get_all_friends]

  resources :friendships, only: [:create, :update, :destroy]
  get '/notifications', to: 'friendships#notifications'

  resources :likes, only: [:create, :destroy]

  post '/posts/:id/', to: 'posts#create_like', as: 'create_like'
  delete '/posts/:id', to: 'posts#destroy_like', as: 'destroy_like'

  resources :posts do
    resources :comments
  end
end