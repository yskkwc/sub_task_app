Rails.application.routes.draw do

  devise_scope :user do
    root 'users/sessions#new'
  end

  devise_for :users, controllers: {
    sessions:           'users/sessions',
    passwords:          'users/passwords',
    registrations:      'users/registrations',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :microposts, only: [:new, :create, :destroy]
  resources :relationships,       only: [:create, :destroy]

  # パスワード変更ページ
  get   '/edit_password'   => 'users#edit_password'
  patch '/update_password' => 'users#update_password'
  put   '/update_password' => 'users#update_password'

  # ログイン前に閲覧可能なページ
  get '/policy'  => 'homes#policy'
  get '/contact' => 'homes#contact'
end
