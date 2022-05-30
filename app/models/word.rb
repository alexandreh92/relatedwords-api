# frozen_string_literal: true

class Word < ApplicationRecord
  # Associations
  has_many :word_associations, dependent: :destroy
  has_many :related_words, through: :word_associations, dependent: :destroy

  has_many :associated_words, foreign_key: :related_word_id, class_name: 'WordAssociation', inverse_of: :related_word,
                              dependent: :destroy
  has_many :parent_words, through: :associated_words, source: :word, dependent: :destroy

  # Validations
  validates :value, uniqueness: true, presence: true
  validates :score, numericality: true

  self.per_page = 20
end
