class PlaylistTiktoksController < ApplicationController
  def create 
    playlist_tiktok = PlaylistTiktok.create(tiktok_id: params["tiktok_id"], playlist_id: params["playlist_id"])
    if playlist_tiktok.save
      render json: { status: 200, playlist_tiktok: playlist_tiktok }
    else
      render json: { status: 500 }
    end
end
end