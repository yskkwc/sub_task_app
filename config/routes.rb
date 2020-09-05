Rails.application.routes.draw do
  get 'users/show'
  devise_scope :user do
    root 'devise/sessions#new'
  end

  devise_for :users, controllers: {
    sessions:      'users/sessions',
    passwords:     'users/passwords',
    registrations: 'users/registrations'
  }

  resources :users, only: [:index, :show]

end
