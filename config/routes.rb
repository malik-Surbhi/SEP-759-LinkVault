Rails.application.routes.draw do

  devise_for :users

  devise_scope :user do
    resources :users
    get 'users/:id/view', to: 'users#view', as: 'view_user'
    patch 'users/:user_id/update_role', to: 'users#update_role', as: 'update_role_user'
  end

  resources :links do
    resource :like, only: [:show, :create, :destroy]
  end

  get 'liked_links', to: 'likes#liked_links', as: :liked_links

  # devise_for  :users, controllers: {
  #   registrations: 'users/registrations' # Adjust the scope as needed
  # }

  # resources :users
  root "links#index"

  #For the APIs
  namespace :api, defaults: { format: 'json' } do
      mount_devise_token_auth_for 'User', at: 'auth'
      # , controllers: {
        # sessions: 'users/sessions',
        # registrations: 'users/registrations'
      # }
      # resources :links
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
