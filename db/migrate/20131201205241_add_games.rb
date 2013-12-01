class AddGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.integer :gid
      t.string :gname
      t.datetime :greleasedate

      t.timestamps
    end
  end
end
