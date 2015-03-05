Rails.application.routes.draw do

  root 'welcome#index'
  get 'terms', to: 'terms#index'
  get 'about', to: 'about#index'
  get 'faq', to: 'common_questions#index'
  resources :users
  resources :projects do
    resources :tasks
  end

  get '/sign-up' => 'registrations#new', as: :signup
  post '/sign-up' => 'registrations#create'
  get '/sign-in' => 'authentication#new', as: :signin
  post '/sign-in' => 'authentication#create'
  get '/sign-out' => 'authentication#destroy', as: :signout

end
