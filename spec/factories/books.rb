FactoryBot.define do
  factory :book do
    sequence(:title, "title_1")
    book_image { "MyString" }
    published_date { "2022-05-01" }
    association :user
  end
end
