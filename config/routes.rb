Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  get 'profile', to: 'profiles#show', as: 'profile'

  resources :activities, except: [:show, :destroy] do
    resources :chatrooms, only: [:show] do
      resources :messages, only: [:create]
    end
    resources :reservations, only: [:new, :create]
    post "reservations/incoming", to: 'reservations#accept_or_reject', as: "incoming"
    resources :likes, only: [:new, :create]
    get "requests", to: 'activities#requests', as: "requests"
  end

  get 'activities/categories', to: 'activities#categories', as: :activity_categories
  get 'activities/categories/:category', to: 'activities#by_category', as: :activities_by_category
  resources :activities, only: [:show]

  resources :reservations, only: [:index, :edit, :update] do
    resources :ratings, only: [:new, :create]
    member do
      patch :accept
      patch :reject
    end
  end

  resources :likes, only: [:destroy]

  get 'cherche', to: 'pages#cherche'
  get 'my_activities', to: 'activities#my_activities', as: 'my_activities'
  post 'activities/:activity_id/like', to: 'likes#create', as: 'like_activity'
  get 'profile/favorites', to: 'profiles#favorites', as: 'profile_favorites'

  get 'reservations/message', to: 'reservations#message_reservation', as: 'message_reservation'
  get 'reservations/requests', to: 'reservations#requests', as: 'reservations_requests'

end
