# frozen_string_literal: true

class CreateWords < ActiveRecord::Migration[6.1]
  def change
    create_table :words do |t|
      t.string :value, null: false
      t.integer :score, null: false, default: 0

      t.timestamps
    end

    add_index :words, :value, unique: true
  end
end
