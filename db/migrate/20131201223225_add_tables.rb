class AddTables < ActiveRecord::Migration
  def change
    create_table :consoles do |t|
      t.integer :gcid
      t.string :gcname
      t.text :gcinfo
      t.string :gcpictureurl
    end

    create_table :tracks do |t|
      t.integer :tid
      t.string :tname
      t.string :tinfo
      t.string :gcpictureurl
    end

    create_table :karts do |t|
      t.integer :kid
      t.string :kname
      t.string :kinfo
      t.string :kpictureurl
    end

    create_table :characters do |t|
      t.integer :cid
      t.string :cname
      t.string :cinfo
      t.string :cpictureurl
    end

    create_table :items do |t|
      t.integer :iid
      t.string :iname
      t.string :iinfo
      t.string :ipictureurl
    end

    create_table :weight do |t|
      t.integer :wid
      t.string :wname
    end

    create_table :console_games do |t|
      t.integer :gcid
      t.string :gid
    end

    create_table :game_tracks do |t|
      t.integer :gid
      t.string :gid
    end

    create_table :game_karts do |t|
      t.integer :gcid
      t.string :tid
    end

    create_table :game_characters do |t|
      t.integer :gid
      t.string :cid
    end

    create_table :game_items do |t|
      t.integer :gid
      t.string :iid
    end

    create_table :character_karts do |t|
      t.integer :cid
      t.string :kid
    end

    create_table :characters_items do |t|
      t.integer :cid
      t.string :iid
    end

  end
end
