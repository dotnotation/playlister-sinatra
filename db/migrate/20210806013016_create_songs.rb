class CreateSongs < ActiveRecord::Migration[5.2]
  def up
    create_table :songs do |t|
      t.string :name
      t.integer :artist_id
    end
  end

  def down
    drop_table :songs
  end
end
