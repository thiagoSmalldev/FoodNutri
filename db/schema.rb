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

ActiveRecord::Schema.define(version: 2023_10_05_201608) do

  create_table "foods", force: :cascade do |t|
    t.datetime "imported_t"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "url"
    t.string "creator"
    t.datetime "created_t"
    t.datetime "last_modified_t"
    t.string "product_name"
    t.string "quantity"
    t.string "brands"
    t.string "categories"
    t.string "labels"
    t.string "cities"
    t.string "purchase_places"
    t.string "stores"
    t.text "ingredients_text"
    t.string "traces"
    t.string "serving_size"
    t.float "serving_quantity"
    t.integer "nutriscore_score"
    t.string "nutriscore_grade"
    t.string "main_category"
    t.string "image_url"
    t.integer "code"
  end

end
