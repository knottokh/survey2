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

ActiveRecord::Schema.define(version: 20180418171847) do

  create_table "answers", force: :cascade do |t|
    t.string "answer"
    t.string "answer2"
    t.string "othertitle"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "school_id"
    t.integer "question_id"
    t.integer "musictype_id"
    t.index ["musictype_id"], name: "index_answers_on_musictype_id"
    t.index ["question_id"], name: "index_answers_on_question_id"
    t.index ["school_id"], name: "index_answers_on_school_id"
  end

  create_table "formmanages", force: :cascade do |t|
    t.boolean "islock"
    t.integer "formtype"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "school_id"
    t.integer "user_id"
    t.index ["school_id"], name: "index_formmanages_on_school_id"
    t.index ["user_id"], name: "index_formmanages_on_user_id"
  end

  create_table "loghistories", force: :cascade do |t|
    t.string "behavior"
    t.string "answer"
    t.string "answer2"
    t.string "othertitle"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "school_id"
    t.integer "user_id"
    t.integer "question_id"
    t.integer "musictype_id"
    t.index ["musictype_id"], name: "index_loghistories_on_musictype_id"
    t.index ["question_id"], name: "index_loghistories_on_question_id"
    t.index ["school_id"], name: "index_loghistories_on_school_id"
    t.index ["user_id"], name: "index_loghistories_on_user_id"
  end

  create_table "musictypes", force: :cascade do |t|
    t.string "title"
    t.integer "formtype"
    t.integer "orderno"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "questions", force: :cascade do |t|
    t.string "title"
    t.string "choice"
    t.string "qtype"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "musictype_id"
    t.index ["musictype_id"], name: "index_questions_on_musictype_id"
  end

  create_table "schools", force: :cascade do |t|
    t.string "education_area"
    t.string "ministry_code"
    t.string "school_name"
    t.string "municipal_area"
    t.string "district"
    t.string "province"
    t.string "postcode"
    t.integer "zone"
    t.integer "students_count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sessions", force: :cascade do |t|
    t.string "session_id", null: false
    t.text "data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["session_id"], name: "index_sessions_on_session_id", unique: true
    t.index ["updated_at"], name: "index_sessions_on_updated_at"
  end

  create_table "tanswers", force: :cascade do |t|
    t.string "prefix"
    t.string "name"
    t.string "surname"
    t.string "status"
    t.string "position"
    t.string "degree"
    t.string "branch"
    t.string "university"
    t.string "topic"
    t.string "remark"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "school_id"
    t.index ["school_id"], name: "index_tanswers_on_school_id"
  end

  create_table "tloghistories", force: :cascade do |t|
    t.string "behavior"
    t.string "prefix"
    t.string "name"
    t.string "surname"
    t.string "status"
    t.string "position"
    t.string "degree"
    t.string "branch"
    t.string "university"
    t.string "topic"
    t.string "remark"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "school_id"
    t.integer "user_id"
    t.index ["school_id"], name: "index_tloghistories_on_school_id"
    t.index ["user_id"], name: "index_tloghistories_on_user_id"
  end

  create_table "tpositions", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tstatusjosbs", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ttopics", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tuniversities", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "role"
    t.string "prefix"
    t.string "name"
    t.string "surname"
    t.string "cardnumber"
    t.string "position"
    t.string "phone"
    t.integer "school_id"
    t.string "username", default: ""
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["school_id"], name: "index_users_on_school_id"
  end

end
