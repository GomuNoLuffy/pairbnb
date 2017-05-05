Rails.application.routes.draw do
  get 'braintree/new'

  root 'page#index'
  resources :passwords, controller: "clearance/passwords", only: [:create, :new]
  resource :session, controller: "sessions", only: [:create]



 resources :users do
   resources :listings
 end

 resources :listings do
   resources :reservations, only: [:create]
 end

  resources :listings, controller: "listings"

  resources :users, controller: "users", only: [:create] do
    resource :password,
      controller: "clearance/passwords",
      only: [:create, :edit, :update]
  end

resources :reservations, controller: "reservations", only: [:destroy]

  get "/sign_in" => "clearance/sessions#new", as: "sign_in"
  delete "/sign_out" => "sessions#destroy", as: "sign_out"
  get "/sign_up" => "clearance/users#new", as: "sign_up"
  get "/auth/:provider/callback" => "sessions#create_from_omniauth"
  get 'tags/:tag', to: 'listings#index', as: :tag
  get '/search', to: 'listings#search'
  get 'braintree/new'
  post 'braintree/checkout'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
