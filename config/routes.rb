Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  resources :activities, except: [:destroy] do
    resources :reservations, only: [:index, :new, :create, :edit, :update] do
      resources :ratings, only: [:new, :create]
    end
    resources :likes, only: [:new, :create]
  end

  resources :chatrooms, only: [:show]
  resources :likes, only: [:destroy]
end
