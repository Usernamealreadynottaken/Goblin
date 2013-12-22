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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20131222171217) do

  create_table "game_categories", :force => true do |t|
    t.string   "name",       :limit => 100
    t.integer  "game_id"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  create_table "games", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "games_relationships", :force => true do |t|
    t.integer  "user_id"
    t.integer  "game_id"
    t.string   "role"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "games_relationships", ["game_id"], :name => "index_games_relationships_on_game_id"
  add_index "games_relationships", ["user_id", "game_id"], :name => "index_games_relationships_on_user_id_and_game_id"
  add_index "games_relationships", ["user_id"], :name => "index_games_relationships_on_user_id"

  create_table "items", :force => true do |t|
    t.string   "name",             :limit => 100
    t.string   "magic_name",       :limit => 100
    t.text     "properties"
    t.text     "description"
    t.boolean  "identified",                      :default => false
    t.integer  "user_id"
    t.integer  "game_category_id"
    t.datetime "created_at",                                         :null => false
    t.datetime "updated_at",                                         :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.string   "password_digest"
    t.string   "remember_token"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["name"], :name => "index_users_on_name", :unique => true
  add_index "users", ["remember_token"], :name => "index_users_on_remember_token"

end
