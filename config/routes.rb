Rails.application.routes.draw do
  devise_for :users
  root to: "timeentries#dashboard"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  post 'book/search', to: "books#search"
  get 'person/search', to: "books#search"
  get 'timeentries/dashboard', to: "timeentries#dashboard"
  get 'timeentry/events', to: "timeentries#subscribe"
  resources :books
  resources :people
  resources :timeentries

  namespace :charts do
    namespace :timeentries do
      get "new"
    end
  end

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :timeentries, only: :index
      post 'timeentries', to: "timeentries#create"
    end
  end
end
