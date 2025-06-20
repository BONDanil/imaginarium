Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "home#index"

  resources :games do
    put :start, on: :member
    resources :rounds, only: :create
    resources :votes, only: :create
    resources :players, only: :create do
      get "/join", to: "players#create", on: :collection
    end
  end

  resources :rounds do
    resources :associations
  end
end
