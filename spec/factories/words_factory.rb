FactoryBot.define do
  factory :word do
    sequence(:value) { |n| "Word#{n}" }
    score { 1 }
  end
end
