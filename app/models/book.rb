class Book < ApplicationRecord
  mount_uploader :book_image, BookImageUploader

  belongs_to :user
  has_many :book_authors, dependent: :destroy
  has_many :authors, through: :book_authors
  has_many :comments, dependent: :destroy

  validates :title, presence: true
  validates :body, length: { minimum: 5 }

  def save_with_author(authors)
    ActiveRecord::Base.transaction do
      self.save!
      self.authors = authors.uniq.reject(&:blank?).map { |name| Author.find_or_initialize_by(name: name.strip) } unless authors.nil?
    end
    true
    rescue StandardError
      false
  end
end
