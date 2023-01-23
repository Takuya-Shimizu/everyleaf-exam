require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
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
        task = FactoryBot.create(:task)
        visit tasks_path
        fill_in 'task[title]', with: 'test'
        click_button '検索'
        expect(page).to have_content 'test'
      end
    end
    context 'ステータス検索をした場合' do
      it "ステータスに完全一致するタスクが絞り込まれる" do
        task = FactoryBot.create(:task)
        visit tasks_path
        select "working", from: "task[status]"
        click_button '検索'
        expect(page).to have_content 'working'
      end
    end
    context 'タイトルのあいまい検索とステータス検索をした場合' do
      it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
        task = FactoryBot.create(:task)
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
        task = FactoryBot.create(:task, title: 'task1')
        visit tasks_path
        expect(page).to have_content 'task1'
      end
    end
    context 'タスクが作成日時の降順に並んでいる場合' do
      it '新しいタスクが一番上に表示される' do
        task = FactoryBot.create(:task, title: 'task1')
        visit tasks_path
        task_list = all('td').first
        expect(task_list).to have_content 'task1'
      end
    end
    context '終了期限でソートするというリンクを押した場合' do
      it 'タスク一覧が終了期限の降順に表示される' do
        task1 = FactoryBot.create(:task)
        task2 = FactoryBot.create(:task, title: '2', deadline: Date.today)
        task3 = FactoryBot.create(:task, title: '3', deadline: '002023-06-14')
        visit tasks_path
        click_on '終了期限でソートする'
        sleep(1)

        task_desc_test = all('td').first
        expect(task_desc_test).to have_content 'test_title'
      end
    end
    context '優先順位でソートするというリンクを押した場合' do
      it 'タスク一覧が優先順位の昇順に表示される' do
        task1 = FactoryBot.create(:task)
        task2 = FactoryBot.create(:task, title: '2', priority: '中')
        task3 = FactoryBot.create(:task, title: '3', priority: '高')
        visit tasks_path
        click_on '優先順位でソートする'
        sleep(1)
        
        task_priority_test = all('td').first
        expect(task_priority_test).to have_content '3'
      end
    end
  end
  describe '詳細表示機能' do
    context '任意のタスク詳細画面に遷移した場合' do
      it '該当タスクの内容が表示される' do
        task = FactoryBot.create(:task)
        visit task_path(task)
        expect(page).to have_content 'test'
      end
    end
  end
end