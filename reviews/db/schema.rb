# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

<<<<<<< HEAD
ActiveRecord::Schema.define(version: 2019_11_20_062029) do

  create_table "users", force: :cascade do |t|
=======
ActiveRecord::Schema.define(version: 2019_11_15_005631) do

  create_table "reviews", force: :cascade do |t|
    t.string "business_id"
    t.string "user_email"
    t.text "comment"
    t.integer "rating"
    t.integer "price"
    t.integer "safety"
    t.integer "service"
    t.boolean "cash_only"
    t.boolean "english"
    t.boolean "tips"
    t.boolean "wifi"
    t.boolean "wheelchair"
>>>>>>> 79cf28f1daba470cfba12578dfb7b14f4f7bf78a
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
