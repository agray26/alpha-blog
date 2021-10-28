Rails.application.routes.draw do
  get 'home/index'
  root 'home#index'
  get 'about', to: 'pages#about'
  resources :articles
  get 'signup', to: 'users#new'
  resources :users, except: [:new]
end
 