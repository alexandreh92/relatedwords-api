class Word < ApplicationRecord
  # Associations
  has_many :word_associations
  has_many :related_words, through: :word_associations

  has_many :associated_words, foreign_key: :related_word_id, class_name: 'WordAssociation'
  has_many :parent_words, through: :associated_words, source: :word

  # Validations
  validates :value, uniqueness: true, presence: true
  validates :score, numericality: true
end
