Rails.application.routes.draw do
  resources :sessions, only: [:new, :create, :destroy]
  get '/login' => 'sessions#new', as: 'login'
  delete '/logout' => 'sessions#destroy', as: 'logout'

  resources :links do
    resource :like, only: [:show, :create, :destroy]
  end

  get 'liked_links', to: 'likes#liked_links', as: :liked_links

  get 'users/:id/view', to: 'users#view', as: 'view_user'
  patch 'users/:user_id/update_role', to: 'users#update_role', as: 'update_role_user'

  resources :users
  get '/register', to: 'users#new', as: 'register'
  root "links#index"

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
