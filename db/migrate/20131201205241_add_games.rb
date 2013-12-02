class AddGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.integer :gid
      t.string :gname
      t.datetime :greleasedate
      t.text :ginfo
      t.string :gpictureurl
    end
  end
end
