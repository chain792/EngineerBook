Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'static_pages#top'
  resources :users, only: %i[new create]
  resources :books do
    collection { get :search }
    resources :comments, only: %i[create update destroy], shallow: true
  end
  resource :profile, only: %i[show edit update]
  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'
end
