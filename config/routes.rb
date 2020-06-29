Rails.application.routes.draw do
  root to: "static#home"

  resources :sessions, only: [:create]
  resources :registrations, only: [:create]
  delete :logout, to: "sessions#logout"
  get :logged_in, to: "sessions#logged_in"

  get "/placeholder/playlist/40c5b468-13af-483d-8728-eb4f85a9f765" => "placeholder_playlist#home"
  get "/placeholder/playlists/" => "placeholder_playlists#home"
  
end
