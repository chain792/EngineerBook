require 'rails_helper'

RSpec.describe 'Profiles', type: :system do
  describe 'プロフィールの表示と編集' do
    context '一般ユーザー' do
    let(:user) { create(:user) }
    before { login_as(user) }

      context '正常系' do
        it 'プロフィールが表示される' do
          visit profile_path
          expect(page).to have_content user.name
          expect(page).to have_content user.email
          expect(page).to have_content user.introduction
          expect(page).to have_content date(user.created_at)
        end

        it 'プロフィールの編集ができる' do
          visit edit_profile_path
          fill_in '名前', with: '名前編集'
          fill_in '自己紹介', with: '自己紹介編集'
          fill_in 'メールアドレス', with: 'edit@example.com'
          file_path = Rails.root.join('spec', 'fixtures', 'test.jpeg')
          attach_file('user[avatar]', file_path)
          click_button '更新する'
          expect(current_path).to eq profile_path
          expect(page).to have_content 'プロフィールを更新しました'
          expect(page).to have_content '名前編集'
          expect(page).to have_content '自己紹介編集'
          expect(page).to have_content 'edit@example.com'
          expect(page).to have_selector "img[src$='test.jpeg']"
        end

        it 'ユーザーが投稿した本の一覧が表示される' do
          book_1 = create(:book, user: user)
          book_2 = create(:book, user: user)
          visit profile_path
          expect(page).to have_content book_1.title
          expect(page).to have_content book_2.title
        end
      end

      context '異常系' do
        it '入力が不足している場合、プロフィールの編集ができない' do
          visit edit_profile_path
          fill_in '名前', with: ''
          fill_in '自己紹介', with: '自己紹介編集'
          file_path = Rails.root.join('spec', 'fixtures', 'test.jpeg')
          attach_file('user[avatar]', file_path)
          click_button '更新する'
          expect(current_path).to eq profile_path
          expect(page).to have_content 'プロフィールを更新できませんでした'
          expect(page).to have_content '名前を入力してください' 
        end
      end
    end

    context 'ゲストユーザー' do
      let(:guest) { create(:user, :guest) }
      before { login_as(guest) }

      it 'ゲストユーザーの場合、メールアドレスが表示されない' do
        visit profile_path
        expect(page).to have_content guest.name
        expect(page).not_to have_content guest.email
        expect(page).to have_content guest.introduction
        expect(page).to have_content date(guest.created_at)
        click_on '編集'
        expect(current_path).to eq edit_profile_path
        expect(page).not_to have_content 'メールアドレス'
      end
    end
  end
end
