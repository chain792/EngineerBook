FactoryBot.define do
  factory :comment do
    user { nil }
    book { nil }
    body { "MyText" }
  end
end
