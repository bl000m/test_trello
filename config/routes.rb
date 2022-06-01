Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  get '/users/connect_trello_account', to: 'users#connect_trello_account'
  get '/users/connect_trello_account_callback', to: 'users#connect_trello_account_callback'

  get 'users/boards', to: 'users#boards'
end
