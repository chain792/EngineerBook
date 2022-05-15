class User < ApplicationRecord
  authenticates_with_sorcery!
  mount_uploader :avatar, AvatarUploader

  has_many :books, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :like_books, through: :likes, source: :book

  validates :password, length: { minimum: 4 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }
  validates :email, presence: true, uniqueness: true
  validates :name, presence: true, length: { maximum: 16 }

  enum role: { general: 0, admin: 1 }

  def own?(object)
    id == object.user_id
  end

  def like?(book)
    like_books.include? book
  end

  def like(book)
    like_books << book
  end

  def unlike(book)
    like_books.destroy book
  end
end
