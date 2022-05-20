class WordAssociation < ApplicationRecord
  # Associations
  belongs_to :word
  belongs_to :related_word, class_name: 'Word', foreign_key: :related_word_id

  # Validations
  validates_uniqueness_of :word_id, scope: :related_word_id
end
