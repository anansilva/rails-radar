Rails.application.routes.draw do
  # get 'users/:id', to: 'users#show'

  resources :ngos do
      resources :donations, only: ['new', 'create', 'update', 'patch']
      resources :conversations do
        resources :messages
      end
  end


  devise_for :users, controllers: {
  sessions: 'users/sessions',
  omniauth_callbacks: 'users/omniauth_callbacks'
  }

  get 'users/:id', to: 'users#show'

  root to: 'ngos#index'

  resources :conversations do
    resources :messages
  end

  get 'users/conversations/:id', controller: 'conversations', action: 'show'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'ngos/:id/dashboard', to: 'ngos#dashboard'
  get 'ngos/:id/unauthorized', to: 'ngos#unauthorized'
end
