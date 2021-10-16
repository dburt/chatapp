Rails.application.routes.draw do
  resources :sessions, only: [:new, :create, :show] do
    get 'destroy'
  end

  resources :messages, only: [:index, :create, :update, :edit] do
    get 'destroy'
  end

  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?

  root "sessions#new"
end
