Rails.application.routes.draw do
  devise_for :users
  root to: "pages#landing"
  get "uikit", to: "pages#uikit"

  get "home", to: "pages#home"
  get "map", to: "pages#map"

  resources :users, only: [:show]

  resources :trips, only: [:new, :create, :update, :destroy] do
    resources :moments, only: [:new, :create]
    resources :steps, only: [:index, :new, :create]
  end

  resources :chatrooms, only: [:index, :show, :create, :destroy] do
    resources :messages, only: [:create]
  end

  resources :steps, only: [:edit, :update, :destroy]
  resources :moments, only: [:destroy]
end
