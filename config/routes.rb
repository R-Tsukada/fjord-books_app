Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks', registrations: "users/registrations" }
  root to: 'books#index'
  resources :books
  resources :users do
    resources :relationship_between_users, only: [:create, :destroy]
    scope module: :users do
      resources :followings, only: :index
      resources :followers, only: :index
    end
  end
end
