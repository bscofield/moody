Moody::Application.routes.draw do
  get "emotions/index"
  resources :moods, only: [:index, :create]

  root 'moods#index'
end
