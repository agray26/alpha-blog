Rails.application.routes.draw do
  get 'home/index'
  root 'home#index'
  get 'about', to: 'pages#about'
  resources :articles
end
 