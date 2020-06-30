class AddingColumnsToPlaylistTiktok < ActiveRecord::Migration[6.0]
  def change
    add_reference :playlist_tiktoks, :tiktok, foreign_key: true
    add_reference :playlist_tiktoks, :playlist, foreign_key: true
  end
end
