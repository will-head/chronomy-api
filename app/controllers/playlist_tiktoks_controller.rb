class PlaylistTiktoksController < ApplicationController
  def self.create(tiktok_id, playlist_id)

    playlist_tiktok = PlaylistTiktok.create(tiktok_id: tiktok_id, playlist_id: playlist_id)
    if playlist_tiktok.save
      render json: { status: 200, playlist_tiktok: playlist_tiktok }
    else
      render json: { status: 500 }
    end
  end
end
