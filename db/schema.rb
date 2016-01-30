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

ActiveRecord::Schema.define(version: 20160130210229) do

  create_table "games", force: :cascade do |t|
    t.integer  "tournament_id"
    t.integer  "team1_id"
    t.integer  "team2_id"
    t.integer  "score1"
    t.integer  "score2"
    t.integer  "position"
    t.datetime "start_time"
    t.boolean  "final",         default: false
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  add_index "games", ["tournament_id", "position"], name: "index_games_on_tournament_id_and_position", unique: true

  create_table "teams", force: :cascade do |t|
    t.string   "school"
    t.string   "shortname"
    t.string   "mascot"
    t.integer  "seed"
    t.integer  "region_id"
    t.integer  "espn_id"
    t.integer  "tournament_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "teams", ["tournament_id", "region_id", "seed"], name: "index_teams_on_tournament_id_and_region_id_and_seed", unique: true

  create_table "tournaments", force: :cascade do |t|
    t.string   "name"
    t.string   "event"
    t.datetime "start_date"
    t.string   "slug"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "tournaments", ["slug"], name: "index_tournaments_on_slug", unique: true

end
