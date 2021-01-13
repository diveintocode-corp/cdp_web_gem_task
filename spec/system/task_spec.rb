require 'rails_helper'
RSpec.describe do
  let!(:task1) { FactoryBot.create(:task1) }
  let!(:task2) { FactoryBot.create(:task2) }
  let!(:task3) { FactoryBot.create(:task3) }
  let!(:task4) { FactoryBot.create(:task4) }
  let!(:task5) { FactoryBot.create(:task5) }
    describe '1.一覧表示' do
      it 'すべてのタスクが表示される' do
        visit tasks_path
        expect(page).to have_content 'タスク1'
        expect(page).to have_content 'タスク2'
        expect(page).to have_content 'タスク3'
        expect(page).to have_content 'タスク4'
        expect(page).to have_content 'タスク5'
      end
    end
    describe '2.キーワード検索が正常に機能する' do
      it 'キーワードに「タスク1」を入力して検索した場合、タスク1のみ表示される' do
        visit tasks_path
        find('input[type="search"]').set('タスク1')
        find('input[type="submit"]').click
        expect(page).to have_content 'タスク1'
        expect(page).not_to have_content 'タスク2'
        expect(page).not_to have_content 'タスク3'
        expect(page).not_to have_content 'タスク4'
        expect(page).not_to have_content 'タスク5'
      end
      it 'キーワードに「内容2」を入力して検索した場合、タスク2のみ表示される' do
        visit tasks_path
        find('input[type="search"]').set('内容2')
        find('input[type="submit"]').click
        expect(page).to have_content 'タスク2'
        expect(page).not_to have_content 'タスク1'
        expect(page).not_to have_content 'タスク3'
        expect(page).not_to have_content 'タスク4'
        expect(page).not_to have_content 'タスク5'
      end
    end
    describe '3.期限での検索が正常に機能する' do
      it '開始期間に「2023-01-01」を入力して検索した場合、タスク3,タスク4,タスク5のみ表示される' do
        visit tasks_path
        fill_in "q_deadline_gteq", with: Date.parse("2023-01-01")
        find('input[type="submit"]').click
        expect(page).to have_content 'タスク3'
        expect(page).to have_content 'タスク4'
        expect(page).to have_content 'タスク5'
        expect(page).not_to have_content 'タスク1'
        expect(page).not_to have_content 'タスク2'
      end
      it '終了期間に「2023-01-01」を入力して検索した場合、タスク1,タスク2,タスク3のみ表示される' do
        visit tasks_path
        fill_in "q_deadline_lteq", with: Date.parse("2023-01-01")
        find('input[type="submit"]').click
        expect(page).to have_content 'タスク1'
        expect(page).to have_content 'タスク2'
        expect(page).to have_content 'タスク3'
        expect(page).not_to have_content 'タスク5'
        expect(page).not_to have_content 'タスク4'
      end
      it '開始期間に「2023-01-01」、終了期間に「2024-01-01」を入力して検索した場合、タスク3,タスク4のみ表示される' do
        visit tasks_path
        fill_in "q_deadline_gteq", with: Date.parse("2023-01-01")
        fill_in "q_deadline_lteq", with: Date.parse("2024-01-01")
        find('input[type="submit"]').click
        expect(page).to have_content 'タスク3'
        expect(page).to have_content 'タスク4'
        expect(page).not_to have_content 'タスク1'
        expect(page).not_to have_content 'タスク2'
        expect(page).not_to have_content 'タスク5'
      end
    end
    describe '4.ステータスによる検索が正常に機能する' do
      it 'ステータスを「指定なし」で検索した場合、すべてのタスクが表示される' do
        visit tasks_path
        choose 'q_status_eq_'
        find('input[type="submit"]').click
        expect(page).to have_content 'タスク1'
        expect(page).to have_content 'タスク2'
        expect(page).to have_content 'タスク3'
        expect(page).to have_content 'タスク4'
        expect(page).to have_content 'タスク5'
      end
      it 'ステータスを「todo」で検索した場合、タスク1,タスク4のみ表示される' do
        visit tasks_path
        choose 'q_status_eq_0'
        find('input[type="submit"]').click
        expect(page).to have_content 'タスク1'
        expect(page).to have_content 'タスク4'
        expect(page).not_to have_content 'タスク2'
        expect(page).not_to have_content 'タスク3'
        expect(page).not_to have_content 'タスク5'
      end
      it 'ステータスを「doing」で検索した場合、タスク2,タスク5のみ表示される' do
        visit tasks_path
        choose 'q_status_eq_1'
        find('input[type="submit"]').click
        expect(page).to have_content 'タスク2'
        expect(page).to have_content 'タスク5'
        expect(page).not_to have_content 'タスク1'
        expect(page).not_to have_content 'タスク3'
        expect(page).not_to have_content 'タスク4'
      end
      it 'ステータスを「done」で検索した場合、タスク3のみ表示される' do
        visit tasks_path
        choose 'q_status_eq_2'
        find('input[type="submit"]').click
        expect(page).to have_content 'タスク3'
        expect(page).not_to have_content 'タスク1'
        expect(page).not_to have_content 'タスク2'
        expect(page).not_to have_content 'タスク4'
        expect(page).not_to have_content 'タスク5'
      end
    end
    describe '5.キーワードと開始期限による検索が正常に機能する' do
      it 'キーワードに「タスク1」、開始期間に「2020-01-01」を入力して検索した場合、タスク1のみ表示される' do
        visit tasks_path
        find('input[type="search"]').set('タスク1')
        fill_in "q_deadline_gteq", with: Date.parse("2020-01-01")
        find('input[type="submit"]').click
        expect(page).to have_content 'タスク1'
        expect(page).not_to have_content 'タスク2'
        expect(page).not_to have_content 'タスク3'
        expect(page).not_to have_content 'タスク4'
        expect(page).not_to have_content 'タスク5'
      end
      it 'キーワードに「タスク1」、開始期間に「2021-01-01」を入力して検索した場合、タスクは1つも表示されない' do
        visit tasks_path
        find('input[type="search"]').set('タスク1')
        fill_in "q_deadline_gteq", with: Date.parse("2021-01-01")
        find('input[type="submit"]').click
        expect(page).not_to have_content 'タスク1'
        expect(page).not_to have_content 'タスク2'
        expect(page).not_to have_content 'タスク3'
        expect(page).not_to have_content 'タスク4'
        expect(page).not_to have_content 'タスク5'
      end
    end
    describe '6.キーワードと開始期限とステータスによる検索が正常に機能する' do
      it 'キーワードに「タスク1」、開始期間に「2020-01-01」、ステータスに「todo」を入力して検索した場合、タスク1のみ表示される' do
        visit tasks_path
        find('input[type="search"]').set('タスク1')
        fill_in "q_deadline_gteq", with: Date.parse("2020-01-01")
        choose 'q_status_eq_0'
        find('input[type="submit"]').click
        expect(page).to have_content 'タスク1'
        expect(page).not_to have_content 'タスク2'
        expect(page).not_to have_content 'タスク3'
        expect(page).not_to have_content 'タスク4'
        expect(page).not_to have_content 'タスク5'
      end
      it 'キーワードに「タスク1」、開始期間に「2020-01-01」、ステータスに「doing」を入力して検索した場合、タスクは1つも表示されない' do
        visit tasks_path
        find('input[type="search"]').set('タスク1')
        fill_in "q_deadline_gteq", with: Date.parse("2020-01-01")
        choose 'q_status_eq_1'
        find('input[type="submit"]').click
        expect(page).not_to have_content 'タスク1'
        expect(page).not_to have_content 'タスク2'
        expect(page).not_to have_content 'タスク3'
        expect(page).not_to have_content 'タスク4'
        expect(page).not_to have_content 'タスク5'
      end
    end
end
