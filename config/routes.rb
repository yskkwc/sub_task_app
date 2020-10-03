Rails.application.routes.draw do

  devise_scope :user do
    root 'homes#home'
  end

  devise_for :users, controllers: {
    sessions:           'users/sessions',
    passwords:          'users/passwords',
    registrations:      'users/registrations',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  resources :users do
    member do
      get :following, :followers, :likes
    end
  end

  resources :microposts, only: [:new, :show, :create, :destroy] do
    resources :comments, only: [:create]
  end

  resources :relationships,          only: [:create, :destroy]
  resources :favorite_relationships, only: [:create, :destroy]
  resources :notifications,          only: [:index] do
    collection do
      delete 'destroy_all'
    end
  end

  # パスワード変更ページ
  get   '/edit_password'   => 'users#edit_password'
  patch '/update_password' => 'users#update_password'
  put   '/update_password' => 'users#update_password'

  # ログイン前に閲覧可能なページ
  get '/home'    => 'homes#home'
  get '/policy'  => 'homes#policy'
  get '/contact' => 'homes#contact'
end
