Rails.application.routes.draw do
  get 'sessions/create'
  get 'reviews/index'
  get 'reviews/new'
  get 'reviews/emergency'
  get '/login', to: redirect('/auth/google_oauth2')
  get '/auth/google_oauth2/callback', to: 'sessions#create'
  resources :reviews
  root 'reviews#index'
end
