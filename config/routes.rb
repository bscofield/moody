Moody::Application.routes.draw do
  resources :moods, only: [:index, :create]

  root 'moods#index'
end
