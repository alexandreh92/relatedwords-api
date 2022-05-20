FactoryBot.define do
  factory :word_association do
    word
    association :related_word, factory: :word
  end
end
