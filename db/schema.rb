# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20160629092617) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "categories_food_items", id: false, force: :cascade do |t|
    t.integer "category_id"
    t.integer "food_item_id"
  end

  add_index "categories_food_items", ["category_id", "food_item_id"], name: "index_categories_food_items_on_category_id_and_food_item_id", using: :btree

  create_table "checkins", force: :cascade do |t|
    t.string   "address"
    t.integer  "post_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float    "lat"
    t.float    "long"
  end

  create_table "comments", force: :cascade do |t|
    t.string   "title",            limit: 50, default: ""
    t.text     "comment"
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.integer  "user_id"
    t.string   "role",                        default: "comments"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["commentable_id"], name: "index_comments_on_commentable_id", using: :btree
  add_index "comments", ["commentable_type"], name: "index_comments_on_commentable_type", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "dislikes", force: :cascade do |t|
    t.integer  "dislikeable_id"
    t.string   "dislikeable_type"
    t.integer  "disliker_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "follows", force: :cascade do |t|
    t.string   "follower_type"
    t.integer  "follower_id"
    t.string   "followable_type"
    t.integer  "followable_id"
    t.datetime "created_at"
  end

  add_index "follows", ["followable_id", "followable_type"], name: "fk_followables", using: :btree
  add_index "follows", ["follower_id", "follower_type"], name: "fk_follows", using: :btree

  create_table "food_items", force: :cascade do |t|
    t.string   "name"
    t.float    "price"
    t.integer  "menu_id"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.integer  "likers_count", default: 0
  end

  create_table "identities", force: :cascade do |t|
    t.string   "provider",   default: ""
    t.string   "uid",        default: ""
    t.string   "url",        default: ""
    t.string   "token",      default: ""
    t.datetime "expires_at"
    t.integer  "user_id"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "likes", force: :cascade do |t|
    t.string   "liker_type"
    t.integer  "liker_id"
    t.string   "likeable_type"
    t.integer  "likeable_id"
    t.datetime "created_at"
  end

  add_index "likes", ["likeable_id", "likeable_type"], name: "fk_likeables", using: :btree
  add_index "likes", ["liker_id", "liker_type"], name: "fk_likes", using: :btree

  create_table "menus", force: :cascade do |t|
    t.string   "name"
    t.text     "summary"
    t.integer  "restaurant_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "messages", force: :cascade do |t|
    t.text     "body"
    t.integer  "status",        default: 0
    t.integer  "restaurant_id"
    t.integer  "user_id"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "notifications", force: :cascade do |t|
    t.integer  "notifier_id"
    t.string   "notifier_type"
    t.integer  "target_id"
    t.string   "target_type"
    t.text     "body"
    t.boolean  "seen",          default: false
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  create_table "photos", force: :cascade do |t|
    t.integer  "imageable_id"
    t.string   "imageable_type"
    t.string   "image"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "posts", force: :cascade do |t|
    t.string   "title"
    t.text     "status"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.integer  "user_id"
    t.integer  "likers_count", default: 0
  end

  create_table "reports", force: :cascade do |t|
    t.text     "reason"
    t.integer  "user_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "reportable_id"
    t.string   "reportable_type"
  end

  create_table "restaurants", force: :cascade do |t|
    t.string   "name"
    t.datetime "opening_time"
    t.datetime "closing_time"
    t.string   "location"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.boolean  "approved",        default: false
    t.integer  "owner_id"
    t.integer  "followers_count", default: 0
    t.integer  "likers_count",    default: 0
    t.boolean  "featured",        default: false
  end

  create_table "reviews", force: :cascade do |t|
    t.string   "title"
    t.text     "summary"
    t.integer  "rating"
    t.integer  "reviewable_id"
    t.string   "reviewable_type"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "reviewer_id"
    t.integer  "likers_count",    default: 0
  end

  create_table "users", force: :cascade do |t|
    t.string   "name",            default: ""
    t.string   "username",        default: ""
    t.string   "email",           default: ""
    t.string   "avatar",          default: ""
    t.string   "location",        default: ""
    t.integer  "gender"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "password"
    t.integer  "role",            default: 0
    t.integer  "followees_count", default: 0
    t.integer  "followers_count", default: 0
    t.integer  "likees_count",    default: 0
    t.boolean  "verified",        default: false
    t.datetime "dob"
  end

end
