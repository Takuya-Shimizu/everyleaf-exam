require 'rails_helper'
RSpec.describe 'ラベル管理機能', type: :system do
  let!(:user) { FactoryBot.create(:user) }
  let!(:task) { FactoryBot.create(:task_second, user: user) }
  before do
    visit new_session_path
    fill_in 'session[email]',	with: "newuser1@sample.com"
    fill_in 'session[password]', with: 'newuser1'
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
  describe '詳細表示機能' do
    context '任意のタスク詳細画面に遷移した場合' do
      it '該当タスクのラベル一覧が表示される' do
        visit tasks_path
        click_on '詳細', match: :first
        expect(page).to have_content 'test1'
      end
    end
  end
  describe 'ラベル検索機能' do
    context '一覧画面でラベルを選択した場合' do
      it 'そのラベルで絞り込みができる' do
        visit tasks_path
        select 'test1', from: 'label_id'
        expect(page).to have_content '999'
      end
    end
  end
end