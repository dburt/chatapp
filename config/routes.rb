Rails.application.routes.draw do
  resources :sessions, only: [:new, :create, :show]

  resources :messages, only: [:index, :create, :update, :edit] do
    get 'destroy'
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # Almost every application defines a route for the root path ("/") at the top of this file.
  root "sessions#new"
end
