Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'tasks#index'

  get 'signup', to:'users#new'
  post 'signup', to: 'users#create'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  resources :users, only: [] do
    resources :tasks, only: :index
  end
  resources :tasks, only: %i[create update]

  namespace :api do
    get 'login', to: 'login#show'
    resources :tasks, only: %i[index create update]
  end
end
