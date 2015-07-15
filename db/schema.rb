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

ActiveRecord::Schema.define(version: 20150714204814) do

  create_table "phone_calls", force: true do |t|
    t.string   "to"
    t.string   "from"
    t.string   "duration"
    t.string   "access_code"
    t.string   "result"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "clipboard"
    t.string   "uuid"
    t.string   "twilio_sid"
    t.string   "status"
    t.integer  "user_id"
    t.datetime "scheduled_at"
  end

  add_index "phone_calls", ["user_id"], name: "index_phone_calls_on_user_id"

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "provider"
    t.string   "uid"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email"
    t.string   "phone"
    t.string   "image"
  end

end
