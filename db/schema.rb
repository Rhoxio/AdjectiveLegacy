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

ActiveRecord::Schema.define(version: 2014_12_26_151055) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "battles", id: :serial, force: :cascade do |t|
    t.integer "current_target"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "characters", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "player_class"
    t.string "gender"
    t.integer "gold"
    t.integer "level"
    t.integer "exp"
    t.integer "special"
    t.integer "max_hp"
    t.integer "current_hp"
    t.integer "skill"
    t.integer "skill_exp"
    t.integer "attack_rating"
    t.integer "initiative"
    t.integer "defense"
    t.string "avatar"
    t.string "headshot"
    t.integer "location", array: true
    t.integer "weapon_id"
    t.integer "shield_id"
    t.string "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "enemies", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "enemy_class"
    t.string "avatar"
    t.integer "level"
    t.integer "exp"
    t.integer "max_hp"
    t.integer "current_hp"
    t.integer "skill"
    t.integer "attack_rating"
    t.integer "initiative"
    t.integer "defense"
    t.integer "gold"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "items", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.integer "value"
    t.string "item_type"
    t.string "item_effect"
    t.integer "attack_modifier"
    t.integer "defense_modifier"
    t.integer "character_id"
    t.integer "count"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "locations", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "js_view"
    t.string "js_controller"
    t.string "js_battle"
    t.string "battle_background"
    t.integer "enemy_types", array: true
    t.string "coordinates"
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_hash"
    t.integer "current_character"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
