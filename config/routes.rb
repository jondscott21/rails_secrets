Rails.application.routes.draw do
  post '/likes' => 'likes#create'
  delete '/likes/:id' => 'likes#destroy'

  get '/secrets' => 'secrets#index'
  post '/secrets' => 'secrets#create'
  delete '/secrets/:id' => 'secrets#destroy'

  get '/users/new' => 'users#new'
  post '/users' => 'users#create'
  get '/users/:id' => 'users#show'
  get '/users/:id/edit' => 'users#edit'
  put '/users/:id' => 'users#update'
  delete '/users/:id' => 'users#destroy'

  get '/sessions/new' => 'sessions#new'
  post '/sessions' => 'sessions#create'
  delete '/sessions/:user_id' => 'sessions#destroy'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
