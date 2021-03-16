Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks', registrations: "users/registrations" }
  root to: 'books#index'
  resources :books
  resources :users do
    resources :followings, module: :users, only: :index
    resources :followers, module: :users, only: :index
  end
  resources :relationships, only: [:create, :destroy]
end
