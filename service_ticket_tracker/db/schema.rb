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

ActiveRecord::Schema[8.0].define(version: 2025_09_05_013918) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  # Custom types defined in this database.
  # Note that some types may not work with other database engines. Be careful if changing database.
  create_enum "priority", ["low", "medium", "high"]
  create_enum "ticket_stage", ["not_scheduled", "install_removal", "scheduled_today", "scheduled_tomorrow", "parts_needed", "parts_ready", "repair_complete"]
  create_enum "work_type", ["install", "removal"]

  create_table "ticket_images", force: :cascade do |t|
    t.string "url"
    t.bigint "ticket_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ticket_id"], name: "index_ticket_images_on_ticket_id"
  end

  create_table "ticket_updates", force: :cascade do |t|
    t.bigint "ticket_id", null: false
    t.string "user_name"
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ticket_id"], name: "index_ticket_updates_on_ticket_id"
  end

  create_table "tickets", force: :cascade do |t|
    t.string "account_name", null: false
    t.string "city", null: false
    t.string "contact_person"
    t.string "contact_info"
    t.enum "priority", default: "low", null: false, enum_type: "priority"
    t.enum "work_type", enum_type: "work_type"
    t.boolean "lease", default: false, null: false
    t.boolean "under_warranty", default: false, null: false
    t.string "machine_model_or_type"
    t.text "issue_description"
    t.string "requesting_tech_name"
    t.integer "assigned_to"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.enum "stage", default: "not_scheduled", null: false, enum_type: "ticket_stage"
    t.datetime "completed_at"
    t.integer "position"
    t.index ["assigned_to"], name: "index_tickets_on_assigned_to"
    t.index ["completed_at"], name: "index_tickets_on_completed_at"
    t.index ["stage", "position"], name: "index_tickets_on_stage_and_position"
    t.index ["stage"], name: "index_tickets_on_stage"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  add_foreign_key "ticket_images", "tickets"
  add_foreign_key "ticket_updates", "tickets"
  add_foreign_key "tickets", "users", column: "assigned_to"
end
