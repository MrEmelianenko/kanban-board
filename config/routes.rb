Rails.application.routes.draw do
  resources :comments
  resources :issues
  resources :projects
  resources :users

  # Authentication routes
  get 'sign-in', to: 'auth#sign_in'
  get 'sign-up', to: 'auth#sign_up'
  delete 'sign-out', to: 'auth#sign_out'
  post 'login', to: 'auth#login'
  post 'register', to: 'auth#register'
  match 'omniauth', to: 'auth#omniauth', via: [:get, :post]
  get '/auth/:provider/callback', to: 'auth#sign_oauth2'

  # Dashboard
  get 'dashboard', to: 'dashboard#index'

  root to: 'dashboard#index'
end
