# frozen_string_literal: true

FactoryBot.define do
  factory :word do
    sequence(:value) { |n| "Word#{n}" }
    score { 1 }

    trait :with_related_words do
      related_words { build_list(:word, 4) }
    end
  end
end
