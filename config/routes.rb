Moody::Application.routes.draw do
  resources :moods, only: [:index]

  root 'moods#index'
end
