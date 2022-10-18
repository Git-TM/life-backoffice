Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  post 'book/search', to: "books#search"
  get 'person/search', to: "books#search"
  get 'timeentries/dashboard', to: "timeentries#dashboard"
  get 'timeentry/events', to: "timeentries#subscribe"
  resources :books
  resources :people
  resources :timeentries
  namespace :api, defaults: { format: :json } do
      namespace :v1 do
        resources :timeentries, only: [ :index, :create ]
      end
    end
  # Defines the root path route ("/")
  # root "articles#index"
end
