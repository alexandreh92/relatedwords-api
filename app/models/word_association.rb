# frozen_string_literal: true

class WordAssociation < ApplicationRecord
  # Associations
  belongs_to :word
  belongs_to :related_word, class_name: 'Word'

  # Validations
  validates :word_id, uniqueness: { scope: :related_word_id }
end
