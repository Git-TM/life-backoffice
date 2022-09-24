Rails.application.routes.draw do
  devise_for :users
  root to: "books#index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :books
  post 'book/search', to: "books#search"
  # Defines the root path route ("/")
  # root "articles#index"
end
