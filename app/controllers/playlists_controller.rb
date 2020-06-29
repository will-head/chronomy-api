require 'securerandom'

class PlaylistsController < ApplicationController

  #create new playlists

  def create
    playlist = Playlist.create!(title: params['playlist']['title'], user_id: session[:user_id], uuid: SecureRandom.hex(20))
    if playlist
      render json: { status: 200, playlist: playlist }
    else
      render json: { status: 500 }
    end
  end

  #find by playlist id

  def show
    playlist = Playlist.find(params[:id])
    if playlist
      render json: { status: 200, playlist: playlist }
    else
      render json: { status: 500 }
    end
  end


  #destroy by playlist id, only if it is the logged in user's playlist

  def destroy 
    playlist = Playlist.find(params[:id])
    if playlist[:user_id] == session[:user_id]
      playlist.destroy
      render json: { status: 200, deleted: true }
    end
  end

  #find by user id, returns nothing if not logged in

  def find_by_user
    playlists_by_user = Playlist.where("user_id = #{session[:user_id]}")
    if playlists_by_user
      render json: { status: 200, playlists_by_user: playlists_by_user }
    else
      render json: { status: 500 }
    end
  end

  #update playlist by id, only if it is the logged in user's playlist
  
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