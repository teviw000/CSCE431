Rails.application.routes.draw do
  get 'reviews/index'
  get 'reviews/new'
  get 'reviews/emergency'
  resources :reviews
  root 'reviews#index'
end
