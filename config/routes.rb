Rails.application.routes.draw do

  devise_scope :user do
    root 'users/sessions#new'
  end

  devise_for :users, controllers: {
    sessions:      'users/sessions',
    passwords:     'users/passwords',
    registrations: 'users/registrations',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  resources :users

  get '/policy'  => 'homes#policy'
  get '/contact' => 'homes#contact'
end
