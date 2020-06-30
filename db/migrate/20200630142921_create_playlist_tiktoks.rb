class CreatePlaylistTiktoks < ActiveRecord::Migration[6.0]
  def change
    create_table :playlist_tiktoks do |t|

      t.timestamps
    end
  end
end
