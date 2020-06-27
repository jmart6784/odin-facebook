Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks', registrations: "registrations" }

  devise_scope :user do
    authenticated :user do
      root 'posts#index', as: :authenticated_root
    end
  
    unauthenticated do
      root 'devise/sessions#new', as: :unauthenticated_root
    end
  end

  resources :users, only: [:index, :show, :friend_request, :befriend, :notifications, :get_all_friends]

  get '/friend_list', to: 'users#friend_list', as: 'friend_list'

  resources :friendships, only: [:create, :update, :destroy]

  resources :likes, only: [:update] do
    member do
      put :index_likes_update
    end
  end

  get '/notifications', to: 'friendships#notifications'

  get '/friend_feed', to: 'posts#friend_feed', as: 'friend_feed'

  resources :posts do
    resources :comments
  end
end