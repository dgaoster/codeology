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

ActiveRecord::Schema.define(version: 20181005194749) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "availabilities", force: :cascade do |t|
    t.datetime "time"
    t.integer  "user_id"
    t.boolean  "is_python"
    t.boolean  "is_videocall"
    t.index ["user_id"], name: "index_availabilities_on_user_id", using: :btree
  end

  create_table "past_interviews", force: :cascade do |t|
    t.integer  "technical_score"
    t.integer  "communication_score"
    t.integer  "problem_solving_score"
    t.integer  "interviewee"
    t.integer  "interviewer"
    t.datetime "time"
    t.text     "feedback_interviewee"
    t.integer  "excitement_score"
    t.integer  "question_score"
    t.integer  "helpfulness_score"
    t.text     "feedback_interviewer"
    t.boolean  "is_python"
    t.boolean  "is_videocall"
  end

  create_table "upcoming_interviews", force: :cascade do |t|
    t.integer  "interviewee"
    t.integer  "interviewer"
    t.datetime "time"
    t.boolean  "is_python"
    t.boolean  "is_videocall"
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.string   "password_digest"
    t.boolean  "is_admin",           default: false
    t.string   "activation_digest"
    t.boolean  "activated",          default: false
    t.datetime "activated_at"
    t.datetime "activation_sent_at"
    t.string   "reset_digest"
    t.datetime "reset_sent_at"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
  end

  add_foreign_key "availabilities", "users"
end
