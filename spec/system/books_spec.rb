require 'rails_helper'

RSpec.describe "Posts", type: :system do
  describe '本のCRUD' do
    let(:user){ create(:user) }
    before { login_as(user) }

    context '正常系' do
      it '検索した本を新規追加できること' do
        visit search_books_path
        fill_in 'search', with: 'apple'
        click_button '検索'
        first('.card-link').click
        fill_in 'レビュー', with: 'レビュー内容'
        select 'プログラミング', from: 'parent_category'
        select 'Ruby', from: 'child_category'
        expect{ click_button '登録する' }.to change { Book.count }.by(1)
        expect(current_path).to eq(books_path)
        expect(page).to have_content('レビューを作成しました')
      end
    end
  end
end
