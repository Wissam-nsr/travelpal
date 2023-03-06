Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  get "uikit", to: static("front.html.erb")

  resources :users, only [:show] do #as profile?
    resources :trips, only [:new, :create, :update, :destroy] do
      resources :moments, only [:new, :create] 
      resources :steps, only [:index, :new, :create]
    end
  end

  resources :chatrooms, only [:index, :show, :create, :destroy] do
    resources :messages, only: [:create]
  end
  resources :steps, only [:edit, :update, :destroy]


end
