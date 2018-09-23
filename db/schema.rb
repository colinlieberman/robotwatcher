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

ActiveRecord::Schema.define(version: 20180923190357) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "pool_readings", force: :cascade do |t|
    t.decimal  "user_rate"
    t.integer  "workers"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "worker_readings", force: :cascade do |t|
    t.integer  "worker_id"
    t.decimal  "rate"
    t.boolean  "alive"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["worker_id"], name: "index_worker_readings_on_worker_id", using: :btree
  end

  create_table "workers", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_workers_on_name", unique: true, using: :btree
  end

end
