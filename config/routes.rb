Rails.application.routes.draw do
  get 'brackets/new'

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'static_pages#index'

  resources :tournaments, only: :show do
    resources :brackets, path: 'brackets'
    member do
      get 'challenge'
      get 'leaderboard'
    end
  end

  namespace :admin do
    root to: 'tournaments#index'

    resources :tournaments do
      resources :teams, only: [:new, :create, :edit, :update]
      resources :games, only: [:edit, :update]
    end
  end

end
