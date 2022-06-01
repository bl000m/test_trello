Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  GET '/users/connect_trello_account', to: 'users#connect_trello'
  GET '/users/connect_trello_account_callback', to: 'users#callback'
end
