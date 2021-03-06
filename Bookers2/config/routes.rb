Rails.application.routes.draw do
  root  "home#top"
  devise_for :users
  get 'home/top'
  get 'home/about'
  resources:books
  resources :users
end
