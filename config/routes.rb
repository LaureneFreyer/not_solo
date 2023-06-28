Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  get 'profile', to: 'profiles#show', as: 'profile'

  resources :activities, except: [:show, :destroy] do
    resources :reservations, only: [:new, :create]
    post "reservations/incoming", to: 'reservations#accept_or_reject', as: "incoming"
    resources :likes, only: [:new, :create]
  end

  get 'activities/categories', to: 'activities#categories', as: :activity_categories
  get 'activities/categories/:category', to: 'activities#by_category', as: :activities_by_category
  resources :activities, only: [:show]

  resources :reservations, only: [:index, :edit, :update] do
    resources :ratings, only: [:new, :create]
  end

  resources :chatrooms, only: [:show]
  resources :likes, only: [:destroy]

  get 'cherche', to: 'pages#cherche'
  get 'my_activities', to: 'activities#my_activities', as: 'my_activities'

end
