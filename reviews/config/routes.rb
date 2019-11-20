Rails.application.routes.draw do
  get 'reviews/index'
  get 'reviews/leave_review/:id', to: 'reviews#leave_review', as: 'leave_review'
  get 'sessions/create'
  get 'reviews/emergency'
  # get '/login', to: redirect('/auth/google_oauth2')
  devise_for :users, controllers: {omniauth_callbacks: 'users/omniauth_callbacks'}
  resources :reviews
  root 'reviews#index'
end
