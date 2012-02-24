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

ActiveRecord::Schema.define(:version => 20120220113652) do

  create_table "mercury_images", :force => true do |t|
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  create_table "roxanne_containers", :force => true do |t|
    t.string   "type"
    t.string   "name"
    t.integer  "page_id"
    t.string   "template"
    t.string   "ancestry"
    t.integer  "sort"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "roxanne_containers", ["ancestry"], :name => "index_roxanne_containers_on_ancestry"

  create_table "roxanne_contents", :force => true do |t|
    t.string   "name"
    t.integer  "container_id"
    t.text     "text"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "roxanne_pages", :force => true do |t|
    t.string   "title"
    t.string   "uri"
    t.string   "layout"
    t.string   "ancestry"
    t.integer  "sort"
    t.integer  "depth",      :default => 0
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "roxanne_pages", ["ancestry"], :name => "index_roxanne_pages_on_ancestry"

  create_table "roxanne_users", :force => true do |t|
    t.string   "username",                                       :null => false
    t.string   "email"
    t.string   "crypted_password"
    t.string   "salt"
    t.datetime "created_at",                                     :null => false
    t.datetime "updated_at",                                     :null => false
    t.string   "remember_me_token"
    t.datetime "remember_me_token_expires_at"
    t.string   "reset_password_token"
    t.datetime "reset_password_token_expires_at"
    t.datetime "reset_password_email_sent_at"
    t.integer  "failed_logins_count",             :default => 0
    t.datetime "lock_expires_at"
  end

  add_index "roxanne_users", ["remember_me_token"], :name => "index_roxanne_users_on_remember_me_token"
  add_index "roxanne_users", ["reset_password_token"], :name => "index_roxanne_users_on_reset_password_token"

end
