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

ActiveRecord::Schema.define(version: 20151010201056) do

  create_table "membership_levels", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "monthly_fee"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "memberships", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "membership_level_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.datetime "expires_at"
  end

  add_index "memberships", ["membership_level_id"], name: "index_memberships_on_membership_level_id"
  add_index "memberships", ["user_id"], name: "index_memberships_on_user_id"

  create_table "phone_calls", force: :cascade do |t|
    t.string   "to",           limit: 255
    t.string   "from",         limit: 255
    t.string   "duration",     limit: 255
    t.string   "access_code",  limit: 255
    t.string   "result",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "clipboard"
    t.string   "uuid",         limit: 255
    t.string   "twilio_sid",   limit: 255
    t.string   "status",       limit: 255
    t.integer  "user_id"
    t.datetime "scheduled_at"
    t.string   "answered_by"
  end

  add_index "phone_calls", ["user_id"], name: "index_phone_calls_on_user_id"

  create_table "users", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "provider",   limit: 255
    t.string   "uid",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email",      limit: 255
    t.string   "phone",      limit: 255
    t.string   "image",      limit: 255
  end

end
