Rails.application.routes.draw do
  get 'reviews/index'
  get 'reviews/leave_review/:id', to: 'reviews#leave_review', as: 'leave_review'
  get 'sessions/create'
  get 'reviews/emergency'
  get '/login', to: redirect('/auth/google_oauth2')
  get '/auth/google_oauth2/callback', to: 'sessions#create'
  resources :reviews
  root 'reviews#index'
end
