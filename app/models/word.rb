class Word < ApplicationRecord
  # Validations
  validates :value, uniqueness: true, presence: true
  validates :score, numericality: true
end
