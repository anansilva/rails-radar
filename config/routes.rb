Rails.application.routes.draw do
  # get 'users/:id', to: 'users#show'

  resources :ngos, only: ['index', 'show'] do
    member do
      resources :donations, only: ['new', 'create', 'update', 'patch']
    end
  end


  devise_for :users, controllers: {
  sessions: 'users/sessions'
  }




  root to: 'ngos#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
