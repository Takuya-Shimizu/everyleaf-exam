require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  let!(:user) { FactoryBot.create(:user) }
  let!(:task) { FactoryBot.create(:task, user: user) }
  describe do
    before do
      visit new_session_path
      fill_in 'session[email]',	with: "newuser1@sample.com"
      fill_in 'session[password]', with: 'newuser1'
      click_on 'Log in'
    end
    describe '新規作成機能' do
      context 'タスクを新規作成した場合' do
        it '作成したタスクが表示される' do
          visit new_task_path
          fill_in 'タイトル', with: 'test'
          fill_in '内容', with: 'test'
          fill_in '終了期限', with: '002023-01-11'
          select "working", from: "task[status]"
          click_button '登録する'
          expect(page).to have_content 'test'
        end
      end
    end
    describe '検索機能' do
      context 'タイトルであいまい検索をした場合' do
        it "検索キーワードを含むタスクで絞り込まれる" do
          task = FactoryBot.create(:task, deadline: '002023-01-31', user_id: user.id)
          visit tasks_path
          fill_in 'task[title]', with: 'test'
          click_button '検索'
          expect(page).to have_content 'test'
        end
      end
      context 'ステータス検索をした場合' do
        it "ステータスに完全一致するタスクが絞り込まれる" do
          task = FactoryBot.create(:task, deadline: '002023-01-31', user_id: user.id)
          visit tasks_path
          select "working", from: "task[status]"
          click_button '検索'
          expect(page).to have_content 'working'
        end
      end
      context 'タイトルのあいまい検索とステータス検索をした場合' do
        it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
          task = FactoryBot.create(:task, deadline: '002023-01-31', user_id: user.id)
          visit tasks_path
          select "working", from: "task[status]"
          click_button '検索'
          expect(page).to have_content 'test'
          expect(page).to have_content 'working'
        end
      end
    end    
    describe '一覧表示機能' do
      context '一覧画面に遷移した場合' do
        it '作成済みのタスク一覧が表示される' do
          task = FactoryBot.create(:task, title: 'task1', deadline: '002023-01-31', user_id: user.id)
          visit tasks_path
          expect(page).to have_content 'task1'
        end
      end
      context 'タスクが作成日時の降順に並んでいる場合' do
        it '新しいタスクが一番上に表示される' do
          task = FactoryBot.create(:task_first, deadline: '002023-10-31', user_id: user.id)
          visit tasks_path
          sleep(1)

          task_list = all('.task_row')
          expect(task_list[0]).to have_content '2'
          expect(task_list[1]).to have_content '1'
        end
      end
      context '終了期限でソートするというリンクを押した場合' do
        it 'タスク一覧が終了期限の降順に表示される' do
          task = FactoryBot.create(:task_first, deadline: '002023-10-31', user_id: user.id)
          visit tasks_path
          click_on '終了期限でソートする'
          sleep(1)

          task_desc_test = all('.task_row')
          expect(task_desc_test[0]).to have_content 'test_title_1'
          expect(task_desc_test[1]).to have_content '2'
        end
      end
      context '優先順位でソートするというリンクを押した場合' do
        it 'タスク一覧が優先順位の昇順に表示される' do
          task = FactoryBot.create(:task_first, deadline: '002023-01-31', user_id: user.id)
          visit tasks_path
          click_on '優先順位でソートする'
          sleep(1)
          
          task_priority_test = all('.task_row')
          expect(task_priority_test[0]).to have_content '1'
          expect(task_priority_test[0]).to have_content '2'
        end
      end
    end
    describe '詳細表示機能' do
      context '任意のタスク詳細画面に遷移した場合' do
        it '該当タスクの内容が表示される' do
          task = FactoryBot.create(:task, deadline: '002023-01-31', user_id: user.id)
          visit task_path(task)
          expect(page).to have_content 'test'
        end
      end
    end
  end
end