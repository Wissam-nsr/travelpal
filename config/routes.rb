Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  get "uikit", to: static("front.html.erb")

  resources "users", only [:show] do
    resources "trips", only [:new, :create, :update] do
      resources "moments", only [:index, :create]
    end
  end

  resources "chatrooms", only [:index, :show, :create, :destroy] do
    resources "messages", only: [:create]
  end

  resources "steps", only [:index, :new, :create, :destroy]

end
