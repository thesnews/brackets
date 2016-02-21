Rails.application.routes.draw do
  get 'brackets/new'

  devise_for :users
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'static_pages#index'

  #resources :tournaments, only: :show

  resources :tournaments, only: :show
  resources :tournaments, only: :none do
    resources :brackets, path: 'brackets'
  end

end
