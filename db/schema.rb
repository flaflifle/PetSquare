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

ActiveRecord::Schema.define(:version => 20130910210240) do

  create_table "checkins", :force => true do |t|
    t.integer  "place_id"
    t.integer  "user_id"
    t.integer  "pet_id"
    t.text     "wayd"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "checkins", ["pet_id"], :name => "index_checkins_on_pet_id"
  add_index "checkins", ["place_id"], :name => "index_checkins_on_place_id"
  add_index "checkins", ["user_id"], :name => "index_checkins_on_user_id"

  create_table "pets", :force => true do |t|
    t.string   "namePet"
    t.string   "breed"
    t.string   "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "user_id"
  end

  add_index "pets", ["user_id"], :name => "index_pets_on_user_id"

  create_table "places", :force => true do |t|
    t.string   "name"
    t.string   "category"
    t.string   "street"
    t.string   "city"
    t.string   "country"
    t.decimal  "latitude"
    t.decimal  "longitude"
    t.boolean  "gmaps",       :default => false
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
    t.string   "description"
  end

  create_table "relationships", :force => true do |t|
    t.integer  "follower_id"
    t.integer  "followed_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "relationships", ["followed_id"], :name => "index_relationships_on_followed_id"
  add_index "relationships", ["follower_id", "followed_id"], :name => "index_relationships_on_follower_id_and_followed_id", :unique => true
  add_index "relationships", ["follower_id"], :name => "index_relationships_on_follower_id"

  create_table "reviews", :force => true do |t|
    t.text     "body"
    t.integer  "place_id"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "reviews", ["place_id"], :name => "index_reviews_on_place_id"
  add_index "reviews", ["user_id"], :name => "index_reviews_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.string   "password_digest"
    t.string   "remember_token"
    t.boolean  "admin",           :default => false
  end

  add_index "users", ["remember_token"], :name => "index_users_on_remember_token"

end
