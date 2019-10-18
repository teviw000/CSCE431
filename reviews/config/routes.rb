Rails.application.routes.draw do
  get 'reviews/index'
  get 'reviews/new'
  resources :reviews
  root 'reviews#index'
end
