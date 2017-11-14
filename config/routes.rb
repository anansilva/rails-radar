Rails.application.routes.draw do
  get 'users/:id', to: 'users#show'

  resources :ngos, only: ['index', 'show']

  devise_for :users
  resources :donations, only: ['create']


  root to: 'ngos#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
