require 'rails_helper'

RSpec.describe Book, type: :model do
  describe 'バリデーション確認' do
    it '有効であること' do
      book = build(:book)
      expect(book).to be_valid
      expect(book.errors).to be_empty
    end

    it 'タイトルがない場合、無効' do
      book = build(:book, title: nil)
      expect(book).to be_invalid
      expect(book.errors[:title]).to eq ["を入力してください"]
    end
  end
end
