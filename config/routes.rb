Rails.application.routes.draw do

  root 'welcome#index'
  get 'terms', to: 'terms#index'
  get 'about', to: 'about#index'
  
end
