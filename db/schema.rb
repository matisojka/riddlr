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

ActiveRecord::Schema.define(version: 20131019205554) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "quizzes", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.string   "goal"
    t.text     "private_environment"
    t.text     "public_environment"
    t.json     "expectations"
    t.text     "solution"
    t.json     "hints"
    t.string   "difficulty"
    t.json     "tags"
    t.string   "author"
    t.boolean  "private"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "permalink"
  end

  add_index "quizzes", ["permalink"], name: "index_quizzes_on_permalink", using: :btree

  create_table "solutions", force: true do |t|
    t.integer  "quiz_id"
    t.text     "code"
    t.boolean  "passed"
    t.json     "expectations"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "time"
    t.integer  "code_length"
  end

  add_index "solutions", ["quiz_id"], name: "index_solutions_on_quiz_id", using: :btree

end
