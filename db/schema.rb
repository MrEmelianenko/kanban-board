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

ActiveRecord::Schema.define(version: 20160530163727) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "comments", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.uuid     "issue_id"
    t.uuid     "creator_id"
    t.text     "text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["creator_id"], name: "index_comments_on_creator_id", using: :btree
    t.index ["issue_id"], name: "index_comments_on_issue_id", using: :btree
  end

  create_table "issue_types", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string "name"
  end

  create_table "issues", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.uuid     "project_id"
    t.uuid     "creator_id"
    t.uuid     "assigned_to_id"
    t.uuid     "issue_type_id"
    t.string   "title",          null: false
    t.text     "description"
    t.integer  "priority"
    t.integer  "estimate"
    t.integer  "state"
    t.datetime "started_at"
    t.datetime "completed_at"
    t.integer  "position",       null: false
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["assigned_to_id"], name: "index_issues_on_assigned_to_id", using: :btree
    t.index ["creator_id"], name: "index_issues_on_creator_id", using: :btree
    t.index ["issue_type_id"], name: "index_issues_on_issue_type_id", using: :btree
    t.index ["project_id"], name: "index_issues_on_project_id", using: :btree
  end

  create_table "project_users", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.uuid    "project_id"
    t.uuid    "user_id"
    t.integer "access_level"
    t.index ["project_id", "user_id"], name: "index_project_users_on_project_id_and_user_id", unique: true, using: :btree
    t.index ["project_id"], name: "index_project_users_on_project_id", using: :btree
    t.index ["user_id"], name: "index_project_users_on_user_id", using: :btree
  end

  create_table "projects", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.uuid     "creator_id"
    t.string   "name"
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["creator_id"], name: "index_projects_on_creator_id", using: :btree
  end

  create_table "settings", id: false, force: :cascade do |t|
    t.string "key",   null: false
    t.text   "value", null: false
    t.index ["key"], name: "index_settings_on_key", unique: true, using: :btree
  end

  create_table "user_accounts", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.uuid     "user_id"
    t.string   "provider"
    t.string   "uid"
    t.jsonb    "data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "provider", "uid"], name: "index_user_accounts_on_user_id_and_provider_and_uid", unique: true, using: :btree
    t.index ["user_id"], name: "index_user_accounts_on_user_id", using: :btree
  end

  create_table "users", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string   "name",                 null: false
    t.string   "email",                null: false
    t.string   "avatar_url"
    t.string   "password_digest"
    t.string   "authentication_token"
    t.integer  "state"
    t.jsonb    "permissions"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
  end

  add_foreign_key "comments", "issues"
  add_foreign_key "comments", "users", column: "creator_id"
  add_foreign_key "issues", "issue_types"
  add_foreign_key "issues", "projects"
  add_foreign_key "issues", "users", column: "creator_id"
  add_foreign_key "project_users", "projects"
  add_foreign_key "project_users", "users"
  add_foreign_key "projects", "users", column: "creator_id"
  add_foreign_key "user_accounts", "users"
end
