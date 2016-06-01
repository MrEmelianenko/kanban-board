Rails.application.routes.draw do
  # Users
  resources :users

  # Projects -> Issues -> Comments
  resources :projects do
    resources :issues do
      resources :comments
    end
  end

  namespace :api do
    resources :issues, only: [:update] do
      member do
        patch :change_state, path: 'change-state'
      end
    end
  end

  # Authentication routes
  get 'sign-in', to: 'auth#sign_in'
  get 'sign-up', to: 'auth#sign_up'
  delete 'sign-out', to: 'auth#sign_out'
  post 'login', to: 'auth#login'
  post 'register', to: 'auth#register'
  match 'omniauth', to: 'omniauth#omniauth', via: [:get, :post]
  get '/auth/:provider/callback', to: 'omniauth#sign_oauth2'

  # Dashboard
  get 'dashboard', to: 'dashboard#index'

  root to: 'dashboard#index'
end
