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

ActiveRecord::Schema.define(version: 2024_08_13_144704) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "application_states", force: :cascade do |t|
    t.integer "singleton_guard", default: 0
    t.string "mock_synchronization_token"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["singleton_guard"], name: "index_application_states_on_singleton_guard", unique: true
  end

  create_table "headers", force: :cascade do |t|
    t.string "name", null: false
    t.string "value", null: false
    t.bigint "mock_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["mock_id"], name: "index_headers_on_mock_id"
  end

  create_table "mocks", force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.integer "status", null: false
    t.string "content_type", null: false
    t.string "request_method", null: false
    t.string "route_path", null: false
    t.string "body_type"
    t.text "body_content"
    t.string "script_type"
    t.text "script"
    t.boolean "active", default: true, null: false
    t.integer "mock_order", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["mock_order"], name: "index_mocks_on_mock_order", unique: true
    t.index ["name"], name: "index_mocks_on_name", unique: true
  end

  add_foreign_key "headers", "mocks", on_delete: :cascade
end
