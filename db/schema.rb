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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130501195147) do

  create_table "ckeditor_assets", :force => true do |t|
    t.string   "data_file_name",                  :null => false
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.integer  "assetable_id"
    t.string   "assetable_type",    :limit => 30
    t.string   "type",              :limit => 30
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
  end

  add_index "ckeditor_assets", ["assetable_type", "assetable_id"], :name => "idx_ckeditor_assetable"
  add_index "ckeditor_assets", ["assetable_type", "type", "assetable_id"], :name => "idx_ckeditor_assetable_type"

  create_table "comments", :force => true do |t|
    t.string   "author"
    t.text     "body"
    t.integer  "story_id"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "comments", ["story_id"], :name => "index_comments_on_story_id"
  add_index "comments", ["user_id"], :name => "index_comments_on_user_id"

  create_table "locales", :force => true do |t|
    t.string   "name"
    t.string   "language"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "pages", :force => true do |t|
    t.string   "title"
    t.text     "content"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "user_id"
    t.integer  "locale_id"
  end

  create_table "permissions", :force => true do |t|
    t.boolean  "hero"
    t.boolean  "pages"
    t.boolean  "stories"
    t.boolean  "comments"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.boolean  "users"
  end

  create_table "permissions_roles", :id => false, :force => true do |t|
    t.integer "permission_id"
    t.integer "role_id"
  end

  add_index "permissions_roles", ["permission_id"], :name => "index_permissions_roles_on_permission_id"
  add_index "permissions_roles", ["role_id"], :name => "index_permissions_roles_on_role_id"

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "stories", :force => true do |t|
    t.string   "title"
    t.text     "content"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "user_id"
    t.integer  "locale_id"
  end

  create_table "users", :force => true do |t|
    t.string   "login"
    t.string   "password_digest"
    t.string   "firstname"
    t.string   "lastname"
    t.string   "email"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.integer  "role_id"
    t.string   "author"
  end

  add_index "users", ["role_id"], :name => "index_users_on_role_id"

end
