Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  get 'profile', to: 'profiles#show', as: 'profile'

  resources :activities, except: [:destroy] do
    # get 'requests', to: 'reservations#requests', as: 'requests'
    resources :reservations, only: [:new, :create]
    resources :likes, only: [:new, :create]
  end

  resources :reservations, only: [:index, :edit, :update] do
    # patch :accept, on: :member
    # patch :reject, on: :member
    resources :ratings, only: [:new, :create]
  end

  resources :chatrooms, only: [:show]
  resources :likes, only: [:destroy]
end
