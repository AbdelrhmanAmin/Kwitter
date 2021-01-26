Rails.application.routes.draw do
  root 'posts#index'
  resources :posts
  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :sessions
  resources :followings
  get 'signup', to: 'users#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
