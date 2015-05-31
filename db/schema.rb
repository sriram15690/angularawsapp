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

ActiveRecord::Schema.define(version: 20150502144833) do

  create_table "blogs", force: :cascade do |t|
    t.string   "title"
    t.string   "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "author"
  end

  create_table "comments", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "contacts", force: :cascade do |t|
    t.string   "name"
    t.string   "mobile_num"
    t.string   "email"
    t.string   "status"
    t.string   "city"
    t.string   "membership"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "eventinstances", force: :cascade do |t|
    t.integer  "event_id"
    t.string   "eventtype"
    t.datetime "eventdate"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "events", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "participants", force: :cascade do |t|
    t.string   "sankalpam_name"
    t.string   "address1"
    t.string   "address2"
    t.string   "city"
    t.integer  "pincode"
    t.string   "state"
    t.string   "gothram"
    t.string   "nakshatram"
    t.string   "rasi"
    t.string   "reference_name"
    t.integer  "roll_num"
    t.integer  "receipt_num"
    t.date     "receipt_date"
    t.date     "renewal_date"
    t.string   "status"
    t.string   "title_name"
    t.string   "telephone"
    t.integer  "sno"
    t.integer  "contact_id"
    t.string   "name"
    t.string   "email"
    t.string   "membership"
    t.string   "mobile_num"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "prasadams", force: :cascade do |t|
    t.integer  "eventinstance_id"
    t.string   "status"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
