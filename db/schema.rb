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

ActiveRecord::Schema.define(:version => 20121119132311) do

  create_table "locations", :force => true do |t|
    t.string   "address"
    t.float    "longitude"
    t.float    "latitude"
    t.boolean  "gmaps"
    t.integer  "zip"
    t.string   "owner_email"
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
    t.string   "description"
    t.integer  "parcelNumber_Value"
    t.string   "altParcelNumber_Value"
    t.string   "name_Value"
    t.string   "name2_Value"
    t.integer  "grossLandValue_Value"
    t.integer  "grossImprovementValue_Value"
    t.integer  "grossAssessedValue_Value"
    t.string   "neighborhoodName_Value"
    t.string   "propertyClass_Value"
    t.string   "propertySubClass_Value"
    t.integer  "taxYear_Value"
    t.integer  "yrConstructed_Value"
    t.integer  "fullBaths_Value"
    t.integer  "halfBaths_Value"
    t.integer  "bedrooms_Value"
    t.string   "improvementType_Value"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
