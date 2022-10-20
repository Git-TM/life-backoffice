# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2022_10_19_214359) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "authors", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "books", force: :cascade do |t|
    t.string "title"
    t.bigint "author_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_id"], name: "index_books_on_author_id"
  end

  create_table "categorytimes", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "people", force: :cascade do |t|
    t.string "firstname"
    t.string "lastname"
    t.date "dob"
    t.bigint "peopletype_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["peopletype_id"], name: "index_people_on_peopletype_id"
  end

  create_table "peopletypes", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "timeentries", force: :cascade do |t|
    t.string "name"
    t.string "tag"
    t.string "description"
    t.datetime "start_date"
    t.datetime "end_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.float "durationinhour"
    t.datetime "date"
    t.bigint "categorytime_id"
    t.index ["categorytime_id"], name: "index_timeentries_on_categorytime_id"
    t.index ["user_id"], name: "index_timeentries_on_user_id"
  end

  create_table "timesubcategories", force: :cascade do |t|
    t.string "name"
    t.boolean "shortweek"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "categorytime_id"
    t.index ["categorytime_id"], name: "index_timesubcategories_on_categorytime_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "books", "authors"
  add_foreign_key "people", "peopletypes"
  add_foreign_key "timeentries", "categorytimes"
  add_foreign_key "timeentries", "users"
  add_foreign_key "timesubcategories", "categorytimes"
end
