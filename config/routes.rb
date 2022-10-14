Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :books
  resources :people
  post 'book/search', to: "books#search"
  get 'person/search', to: "books#search"
  namespace :api, defaults: { format: :json } do
      namespace :v1 do
        resources :timentries, only: [ :index ]
      end
    end
  # Defines the root path route ("/")
  # root "articles#index"
end
