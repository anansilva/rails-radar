Rails.application.routes.draw do
  # get 'users/:id', to: 'users#show'

  resources :ngos, only: ['index', 'show', 'new', 'create'] do
      resources :donations, only: ['new', 'create', 'update', 'patch']
  end


  devise_for :users, controllers: {
  sessions: 'users/sessions',
  omniauth_callbacks: 'users/omniauth_callbacks'
  }

  get 'users/:id', to: 'users#show'

  root to: 'ngos#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
