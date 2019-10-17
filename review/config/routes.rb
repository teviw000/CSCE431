Rails.application.routes.draw do
  get 'review/index'
  get 'review/new'
  get 'review/edit'
  resources :review, except: :destroy
  root 'review#index'

end
