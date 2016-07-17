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

ActiveRecord::Schema.define(version: 20160304185718) do

  create_table "constructors", force: :cascade do |t|
    t.string   "name",          limit: 255
    t.string   "nationality",   limit: 255
    t.integer  "n_champion",    limit: 4
    t.string   "constructorId", limit: 255
    t.string   "chassis",       limit: 255
    t.string   "car_name",      limit: 255
    t.string   "engine",        limit: 255
    t.integer  "points",        limit: 4,   default: 0
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.integer  "position",      limit: 4
  end

  add_index "constructors", ["constructorId"], name: "index_constructors_on_constructorId", using: :btree

  create_table "constructors_drivers", force: :cascade do |t|
    t.integer "constructor_id", limit: 4
    t.integer "driver_id",      limit: 4
  end

  add_index "constructors_drivers", ["constructor_id", "driver_id"], name: "index_constructors_drivers", using: :btree

  create_table "drivers", force: :cascade do |t|
    t.string   "role",           limit: 255
    t.string   "givenName",      limit: 255
    t.string   "familyName",     limit: 255
    t.string   "dob",            limit: 255
    t.string   "nationality",    limit: 255
    t.integer  "number",         limit: 4
    t.string   "driverId",       limit: 255
    t.boolean  "active",                     default: false
    t.string   "n_champion",     limit: 255, default: "0"
    t.integer  "constructor_id", limit: 4
    t.integer  "points",         limit: 4,   default: 0
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.integer  "position",       limit: 4
  end

  add_index "drivers", ["constructor_id"], name: "index_drivers_on_constructor_id", using: :btree
  add_index "drivers", ["driverId"], name: "index_drivers_on_driverId", using: :btree

  create_table "events", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "nation",     limit: 255
    t.string   "city",       limit: 255
    t.integer  "round",      limit: 4
    t.string   "p_winner",   limit: 255, default: ""
    t.string   "tyres",      limit: 255
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.integer  "laps",       limit: 4,   default: 0
  end

  create_table "qualis", force: :cascade do |t|
    t.string   "position",       limit: 255
    t.string   "q1time",         limit: 255
    t.string   "q2time",         limit: 255
    t.string   "q3time",         limit: 255
    t.string   "tyres",          limit: 255
    t.integer  "driver_id",      limit: 4
    t.integer  "constructor_id", limit: 4
    t.integer  "event_id",       limit: 4
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "qualis", ["driver_id"], name: "index_qualis_on_driver_id", using: :btree
  add_index "qualis", ["event_id"], name: "index_qualis_on_event_id", using: :btree

  create_table "races", force: :cascade do |t|
    t.string   "position",       limit: 255
    t.integer  "grid",           limit: 4
    t.string   "time",           limit: 255
    t.string   "status",         limit: 255
    t.string   "tyres",          limit: 255
    t.integer  "driver_id",      limit: 4
    t.integer  "constructor_id", limit: 4
    t.integer  "event_id",       limit: 4
    t.integer  "points",         limit: 4,   default: 0
    t.string   "positionText",   limit: 255
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.integer  "laps",           limit: 4,   default: 0
  end

  add_index "races", ["constructor_id"], name: "index_races_on_constructor_id", using: :btree
  add_index "races", ["driver_id"], name: "index_races_on_driver_id", using: :btree
  add_index "races", ["event_id"], name: "index_races_on_event_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "provider",               limit: 255,   default: "email", null: false
    t.string   "uid",                    limit: 255,   default: "",      null: false
    t.string   "encrypted_password",     limit: 255,   default: "",      null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,     default: 0,       null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.string   "confirmation_token",     limit: 255
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email",      limit: 255
    t.string   "name",                   limit: 255
    t.string   "nickname",               limit: 255
    t.string   "image",                  limit: 255
    t.string   "email",                  limit: 255
    t.text     "tokens",                 limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true, using: :btree

end
