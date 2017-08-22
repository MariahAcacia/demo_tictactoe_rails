Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "tic_tac_toe#new"

  get '/new' => 'tic_tac_toe#new'
  post '/make_move' => 'tic_tac_toe#make_move'


end
