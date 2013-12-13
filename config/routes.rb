Moody::Application.routes.draw do
  resources :emotions, only: [:index, :update]
  resources :moods, only: [:index, :create]

  root 'moods#index'
end
