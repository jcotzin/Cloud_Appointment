Rails.application.routes.draw do
  # root 'sessions#new'
  get '/login' => 'sessions#new'

  post '/login' =>  'sessions#create'

  get '/logout' => 'sessions#destroy'

  get '/signup' => 'patients#new'
  post '/patients' => 'patients#create'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
