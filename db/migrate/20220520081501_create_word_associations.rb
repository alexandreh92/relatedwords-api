class CreateWordAssociations < ActiveRecord::Migration[6.1]
  def change
    create_table :word_associations do |t|
      t.integer :word_id, foreign_key: true, index: true
      t.integer :related_word_id, foreign_key: true, index: true

      t.timestamps
    end

    add_index :word_associations, %i[word_id related_word_id], unique: true
  end
end
