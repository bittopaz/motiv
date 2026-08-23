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

ActiveRecord::Schema[8.1].define(version: 2026_08_23_120228) do
  create_table "goals", force: :cascade do |t|
    t.boolean "completed", default: false, null: false
    t.datetime "created_at", null: false
    t.text "motivation"
    t.string "title", null: false
    t.datetime "updated_at", null: false
  end

  create_table "resblocks", force: :cascade do |t|
    t.text "address"
    t.string "bizcircle"
    t.string "building_type"
    t.integer "built_year"
    t.datetime "created_at", null: false
    t.string "district", null: false
    t.decimal "green_coverage_pct", precision: 5, scale: 2
    t.decimal "management_fee_cny", precision: 6, scale: 2
    t.integer "metro_walk_distance_m"
    t.string "name", null: false
    t.string "nearest_metro_station"
    t.text "notes"
    t.integer "on_market_unit_count"
    t.decimal "plot_ratio", precision: 4, scale: 2
    t.integer "reference_unit_price"
    t.string "source_platform", default: "lianjia", null: false
    t.string "source_resblock_id"
    t.string "source_url"
    t.integer "total_unit_count"
    t.datetime "updated_at", null: false
    t.index ["bizcircle"], name: "index_resblocks_on_bizcircle"
    t.index ["built_year"], name: "index_resblocks_on_built_year"
    t.index ["district"], name: "index_resblocks_on_district"
    t.index ["reference_unit_price"], name: "index_resblocks_on_reference_unit_price"
    t.index ["source_platform", "source_resblock_id"], name: "index_resblocks_on_source_platform_and_source_resblock_id", unique: true, where: "source_resblock_id IS NOT NULL"
  end
end
