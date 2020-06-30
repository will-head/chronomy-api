require 'securerandom' 

class PlaylistsController < ApplicationController

  # create new playlists

  def create
    playlist = create_playlist(params['playlist']['title'])
    if playlist.save
      render json: { status: 200, playlist: playlist }
      create_tiktoks_and_playlist_tiktoks(params['playlist']['tiktoks'], playlist[:id])
    else
      render json: { status: 500 }
    end
  end

  # find by playlist uuid

  def show

    playlist = Playlist.find_by(uuid: params[:id])
    playlist_id = playlist[:id]
    tiktoks = PlaylistTiktok.where("playlist_id = #{playlist_id}")
    array_of_tiktoks = tiktoks_array(tiktoks)
    if playlist
      render json: { status: 200, playlist: playlist, tiktoks: array_of_tiktoks }
    else
      render json: { status: 500 }
    end
  end

  # destroy by playlist uuid, only if it is the logged in user's playlist

  def destroy 
    playlist = Playlist.find_by(uuid: params[:id])
    return unless playlist[:user_id] == session[:user_id]

    PlaylistTiktok.where("playlist_id = #{playlist[:id]}").delete_all
    playlist.destroy
    render json: { status: 200, deleted: true }
  end

  # find by user id, returns nothing if not logged in

  def find_by_user
    playlists_by_user = Playlist.where("user_id = #{session[:user_id]}")
    if playlists_by_user
      render json: { status: 200, playlists_by_user: playlists_by_user }
    else
      render json: { status: 500 }
    end
  end

  # update playlist by uuid, only if it is the logged in user's playlist
  
  def update
    playlist = Playlist.find_by(uuid: params[:id])
    if playlist[:username] == session[:username]
      playlist.update(title: params['playlist']['title'])
      render json: { status: 200, playlist: playlist }

      # update the tiktoks and update the playlist tiktoks

    else
      render json: { status: 500 }
    end
  end

  private

  def tiktoks_array(tiktoks)
    array_of_tiktoks = []
    tiktoks.each do |tiktok|
      temp = Tiktok.find(tiktok.tiktok_id)
      array_of_tiktoks.push({
        title: temp["title"],
        mp4_url: temp["mp4_url"]
      })
    end
    return array_of_tiktoks
  end

  def create_tiktoks_and_playlist_tiktoks(tiktoks, playlist_id)
    tiktoks.each do |tiktok_url|
      tiktok_id = add_tiktok(tiktok_url)    
      PlaylistTiktoksController.create(tiktok_id, playlist_id)
    end
  end

  def add_tiktok(url)
    tiktok_unique_url = TiktoksController.unshorten(url)
    result = Tiktok.find_by(original_url: tiktok_unique_url)
    if result 
      tiktok_id = result.id 
    else
      tiktok = TiktoksController.create(tiktok_unique_url)
      tiktok_id = JSON(tiktok)["tiktok"]["id"]
    end
    tiktok_id
  end

  def create_playlist(title)
    return Playlist.create(
      title: title, 
      user_id: session[:user_id], 
      uuid: SecureRandom.uuid
    )
  end
end
