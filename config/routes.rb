Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  get "uikit", to: "pages#uikit"

  get "landing", to: "pages#landing"

  get "map", to: "pages#map"

  resources :users, only: [:show]

  resources :trips, only: [:new, :create, :update, :destroy] do
    resources :steps, only: [:index, :new, :create]
  end

  resources :moments, only: [:new, :create, :destroy]

  resources :chatrooms, only: [:index, :show, :create, :destroy] do
    resources :messages, only: [:create]
  end

  resources :steps, only: [:edit, :update, :destroy]
  
end
