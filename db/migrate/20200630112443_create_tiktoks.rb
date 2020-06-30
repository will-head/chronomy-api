class CreateTiktoks < ActiveRecord::Migration[6.0]
  def change
    create_table :tiktoks do |t|
      t.string :original_url
      t.string :mp4_url
      t.string :title

      t.timestamps
    end
  end
end
