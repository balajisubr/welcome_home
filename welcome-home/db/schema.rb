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

ActiveRecord::Schema[7.1].define(version: 2023_12_06_211128) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "floor_plan_types", force: :cascade do |t|
    t.string "floor_plan_type"
    t.index ["floor_plan_type"], name: "index_floor_plan_types_on_floor_plan_type", unique: true
  end

  create_table "occupancies", force: :cascade do |t|
    t.string "resident"
    t.datetime "move_in"
    t.datetime "move_out"
    t.integer "unit_id"
  end

  create_table "units", force: :cascade do |t|
    t.integer "unit_number"
    t.integer "floor_plan_type_id"
    t.index ["unit_number"], name: "index_units_on_unit_number", unique: true
  end

  add_foreign_key "occupancies", "units"
  add_foreign_key "units", "floor_plan_types"
end
