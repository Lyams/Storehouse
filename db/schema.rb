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

ActiveRecord::Schema.define(version: 2021_08_20_144634) do

  create_table "commodities", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "deliveries", force: :cascade do |t|
    t.integer "storehouse_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.date "date_of_delivery", null: false
    t.index ["storehouse_id"], name: "index_deliveries_on_storehouse_id"
  end

  create_table "storehouses", force: :cascade do |t|
    t.string "title", null: false
    t.string "district", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "things", force: :cascade do |t|
    t.integer "value", null: false
    t.integer "commodity_id", null: false
    t.string "shipment_type", null: false
    t.integer "shipment_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["commodity_id"], name: "index_things_on_commodity_id"
    t.index ["shipment_type", "shipment_id"], name: "index_things_on_shipment"
  end

  create_table "transfers", force: :cascade do |t|
    t.integer "sender_id"
    t.integer "recipient_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["recipient_id"], name: "index_transfers_on_recipient_id"
    t.index ["sender_id"], name: "index_transfers_on_sender_id"
  end

  add_foreign_key "deliveries", "storehouses"
  add_foreign_key "things", "commodities"
  add_foreign_key "transfers", "storehouses", column: "recipient_id"
  add_foreign_key "transfers", "storehouses", column: "sender_id"
end
