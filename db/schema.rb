# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20131201223225) do

  create_table "character_karts", force: true do |t|
    t.integer "cid"
    t.integer "kid"
  end

  create_table "characters", force: true do |t|
    t.integer "cid"
    t.string  "cname"
    t.string  "cinfo"
    t.string  "cpictureurl"
  end

  create_table "characters_items", force: true do |t|
    t.integer "cid"
    t.integer "iid"
  end

  create_table "console_games", force: true do |t|
    t.integer "gcid"
    t.integer "gid"
  end

  create_table "consoles", force: true do |t|
    t.integer "gcid"
    t.string  "gcname"
    t.text    "gcinfo"
    t.string  "gcpictureurl"
  end

  create_table "game_characters", force: true do |t|
    t.integer "gid"
    t.integer "cid"
    t.integer "wid"
  end

  create_table "game_items", force: true do |t|
    t.integer "gid"
    t.integer "iid"
  end

  create_table "game_karts", force: true do |t|
    t.integer "gcid"
    t.integer "tid"
    t.integer "wid"
  end

  create_table "game_tracks", force: true do |t|
    t.integer "gid"
    t.integer "tid"
  end

  create_table "games", force: true do |t|
    t.integer  "gid"
    t.string   "gname"
    t.datetime "greleasedate"
    t.text     "ginfo"
    t.string   "gpictureurl"
  end

  create_table "items", force: true do |t|
    t.integer "iid"
    t.string  "iname"
    t.string  "iinfo"
    t.string  "ipictureurl"
  end

  create_table "karts", force: true do |t|
    t.integer "kid"
    t.string  "kname"
    t.string  "kinfo"
    t.string  "kpictureurl"
  end

  create_table "tracks", force: true do |t|
    t.integer "tid"
    t.string  "tname"
    t.string  "tinfo"
    t.string  "tpictureurl"
  end

  create_table "weight", force: true do |t|
    t.integer "wid"
    t.string  "wname"
  end

end
