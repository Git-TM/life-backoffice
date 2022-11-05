Rails.application.routes.draw do
  devise_for :users
  root to: "timeentries#dashboard"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  post 'book/search', to: "books#search"
  get 'person/search', to: "books#search"
  get 'timeentries/dashboard', to: "timeentries#dashboard"
  get 'timeentry/events', to: "timeentries#subscribe"
  get 'expenses/dashboard', to: "expenses#dashboard"
  resources :books
  resources :people
  resources :timeentries


  post 'timewebhooks', to: "timewebhooks#create"
  # get '/timewebhooks', to: "timewebhooks#create"

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :timeentries, only: :index
      post 'timeentries', to: "timeentries#create"
    end
  end
end
