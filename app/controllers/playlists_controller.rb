require 'securerandom' 

class PlaylistsController < ApplicationController

  # create new playlists

  def create
    playlist = Playlist.create(
      title: params['playlist']['title'], 
      user_id: session[:user_id], 
      uuid: SecureRandom.uuid
      )
    if playlist.save
      render json: { status: 200, playlist: playlist }
      params['playlist']['tiktoks'].each{ |url|
        tiktok = TiktoksController.create(url)
        tiktok_id = JSON(tiktok)["tiktok"]["id"]
        playlist_id = playlist[:id]
        PlaylistTiktoksController.create(tiktok_id, playlist_id)
      }
    else
      render json: { status: 500 }
    end
  end

  # find by playlist id

  def show

    # change to find by uuid
    playlist = Playlist.find(params[:id])

    # get all tiktoks with that playlist_id

    # for each of those, get the tiktok title and mp4 link

    # build the json response with all the tiktok titles and mp4 urls and return it

    if playlist
      render json: { status: 200, playlist: playlist }
    else
      render json: { status: 500 }
    end
  end

  # destroy by playlist id, only if it is the logged in user's playlist

  def destroy 
    playlist = Playlist.find(params[:id])
    return unless playlist[:user_id] == session[:user_id]

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

  # update playlist by id, only if it is the logged in user's playlist
  
  def update
    playlist = Playlist.find(params[:id])
    if playlist[:username] == session[:username]
      playlist.update(title: params['playlist']['title'])
      render json: { status: 200, playlist: playlist }
    else
      render json: { status: 500 }
    end
  end
end
