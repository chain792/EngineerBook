class Book < ApplicationRecord
  mount_uploader :book_image, BookImageUploader

  belongs_to :user

  validates :title, presence: true
  validates :body, length: { minimum: 5 }
end
