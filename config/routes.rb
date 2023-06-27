Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  get 'profile', to: 'profiles#show', as: 'profile'

  resources :activities, except: [:destroy] do
    resources :reservations, only: [:new, :create]
    post "reservations/incoming", to: 'reservations#accept_or_reject', as: "incoming"
    resources :likes, only: [:new, :create]
  end

  resources :reservations, only: [:index, :edit, :update] do
    resources :ratings, only: [:new, :create]
  end

  resources :chatrooms, only: [:show]
  resources :likes, only: [:destroy]
end
