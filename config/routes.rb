Rails.application.routes.draw do
  root to: "static#home"

  resources :sessions, only: [:create]

  get "/placeholder/playlist/40c5b468-13af-483d-8728-eb4f85a9f765" => "placeholder_playlist#home"
  get "/placeholder/playlists/" => "placeholder_playlists#home"
  
end
