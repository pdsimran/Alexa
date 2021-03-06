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

ActiveRecord::Schema.define(version: 20170328142730) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "dump_sites", force: :cascade do |t|
    t.string   "name"
    t.integer  "india_rank"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_dump_sites_on_name", using: :btree
  end

  create_table "seed_sites", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "score"
    t.index ["name"], name: "index_seed_sites_on_name", using: :btree
  end

  create_table "site_infos", force: :cascade do |t|
    t.string   "name"
    t.integer  "india_rank"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_site_infos_on_name", using: :btree
  end

end
