Rails.application.routes.draw do
  get 'reviews/index'
  get 'reviews/leave_review/:id', to: 'reviews#leave_review', as: 'leave_review'
  get 'reviews/emergency'
  resources :reviews
  root 'reviews#index'
end
