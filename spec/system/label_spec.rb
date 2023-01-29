require 'rails_helper'
RSpec.describe 'ラベル管理機能', type: :system do
#   user_third = FactoryBot.create(:user_third)
#   task = FactoryBot.create(:task_second, user: user_third)
  describe do
    before do
      visit new_session_path
      fill_in 'session[email]',	with: "newuserxxx@sample.com"
      fill_in 'session[password]', with: 'newuserxxx'
      click_on 'Log in'
    end
    describe '新規作成機能' do
      context 'タスクを新規作成した場合' do
        it '作成したタスクに付けられたラベルが表示される' do
          visit new_task_path
          fill_in 'タイトル', with: 'test'
          fill_in '内容', with: 'test'
          fill_in '終了期限', with: '002023-01-11'
          select "working", from: "task[status]"
          check "test1"
          click_button '登録する'
          expect(page).to have_content 'test1'
        end
      end
    end
    # describe '編集機能' do
    #   context 'タスクを編集した場合' do
    #     it '作成したタスクに新たに付けられたラベルが表示され、外したラベルは表示されない' do
    #       visit edit_task_path
    #       fill_in 'タイトル', with: '編集後'
    #       fill_in '内容', with: '編集後'
    #       fill_in '終了期限', with: '002023-12-31'
    #       select "waiting", from: "task[status]"
    #       check 'test8'
    #       click_button '登録する'
    #       expect(page).to have_content 'test8'
    #     end
    #   end
    # end
    describe '詳細表示機能' do
      context '任意のタスク詳細画面に遷移した場合' do
        it '該当タスクのラベル一覧が表示される' do
          FactoryBot.create(:task_second, deadline: '002023-10-31')
          click_on '詳細', match: :first
          expect(page).to have_content 'test1'
        end
      end
    end
  end
end