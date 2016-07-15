Rails.application.routes.draw do
  resources :phones
  resources :phone_calls

  root to: 'visitors#index'
  get '/auth/:provider/callback' => 'sessions#create'
  get '/signin' => 'sessions#new', :as => :signin
  get '/signout' => 'sessions#destroy', :as => :signout
  get '/auth/failure' => 'sessions#failure'
  match '/edit_profile' => 'users#profile', :as => 'user', via: [:get, :patch]
  match '/phone_calls/:uuid' => 'phone_calls#conference', via: [:get, :post]
  match '/phone_calls/:uuid/callback' => 'phone_calls#callback', via: [:get, :post]
  get '/phone_calls/:id/redial' => 'phone_calls#redial', as: :redial
  post 'twilio/voice' => 'twilio#voice'
  post 'twilio/response' => 'twilio#response'
  get 'twilio/callstatus' => 'visitors#callstatus'
end
