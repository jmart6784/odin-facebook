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

  resources :users, only: [:index, :show]

  delete "removefriend" => "friendships#destroy"
  resources :friendships

  get 'users/:target_id/friend_request', to: 'users#friend_request', as: 'request'
  
  get '/notifications', to: 'users#notifications', as: 'notificaion'

  resources :posts do
    resources :comments
  end
end
