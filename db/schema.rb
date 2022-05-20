# frozen_string_literal: true

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

ActiveRecord::Schema.define(version: 20_220_520_081_501) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'word_associations', force: :cascade do |t|
    t.integer 'word_id'
    t.integer 'related_word_id'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['related_word_id'], name: 'index_word_associations_on_related_word_id'
    t.index %w[word_id related_word_id], name: 'index_word_associations_on_word_id_and_related_word_id', unique: true
    t.index ['word_id'], name: 'index_word_associations_on_word_id'
  end

  create_table 'words', force: :cascade do |t|
    t.string 'value', null: false
    t.integer 'score', default: 0, null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['value'], name: 'index_words_on_value', unique: true
  end
end
