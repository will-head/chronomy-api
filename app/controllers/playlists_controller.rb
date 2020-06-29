class PlaylistsController < ApplicationController

  def create
    playlist = Playlist.create!(title: params['playlist']['title'], user_id: session[:user_id], uuid: generate_uuid) 
  end

  private

  def generate_uuid
    "40c5b468-13af-483d-8728-eb4f85a9f765"
  end

end