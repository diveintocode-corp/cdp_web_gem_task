require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
    let!(:task1) { FactoryBot.create(:task1) }
    let!(:task2) { FactoryBot.create(:task2) }
    let!(:task3) { FactoryBot.create(:task3) }
    let!(:task4) { FactoryBot.create(:task4) }
    let!(:task5) { FactoryBot.create(:task5) }
  describe '一覧表示機能' do
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        visit tasks_path
        expect(page).to have_content 'タスク1'
        expect(page).to have_content 'タスク2'
        expect(page).to have_content 'タスク3'
        expect(page).to have_content 'タスク4'
        expect(page).to have_content 'タスク5'
      end
    end
    context 'タスク1で検索した場合' do
      it 'タスク1のみ表示される' do
        visit tasks_path
        fill_in 'キーワード', with: 'タスク1'
        expect(page).to have_content 'タスク1'
        expect(page).not_to have_content 'タスク2'
        expect(page).not_to have_content 'タスク3'
        expect(page).not_to have_content 'タスク4'
        expect(page).not_to have_content 'タスク5'
      end
    end
  end
end
