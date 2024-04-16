Rails.application.routes.draw do
  resources :users
  resources :shops

  post ('/login'), to: 'sessions#login'
  post ('/logout'), to: 'sessions#logout'
  post ('/admin'), to: 'admin#create'

end
