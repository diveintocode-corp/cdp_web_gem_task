require 'rails_helper'
RSpec.describe do
  let!(:task1) { FactoryBot.create(:task1) }
  let!(:task2) { FactoryBot.create(:task2) }
  let!(:task3) { FactoryBot.create(:task3) }
  let!(:task4) { FactoryBot.create(:task4) }
  let!(:task5) { FactoryBot.create(:task5) }
    describe '1.タスク一覧画面にすべてのタスクが表示されること' do
      it 'すべてのタスクが表示されること' do
        visit tasks_path
        expect(page).to have_content 'タスク1'
        expect(page).to have_content 'タスク2'
        expect(page).to have_content 'タスク3'
        expect(page).to have_content 'タスク4'
        expect(page).to have_content 'タスク5'
      end
    end
    describe '2.1つのフォームでtitleとdescriptionのどちらでもあいまい検索ができること' do
      it 'titleによるあいまい検索が正常に機能すること' do
        visit tasks_path
        find('input[type="search"]').set('タスク1')
        find('input[type="submit"]').click
        expect(page).to have_content 'タスク1'
        expect(page).not_to have_content 'タスク2'
        expect(page).not_to have_content 'タスク3'
        expect(page).not_to have_content 'タスク4'
        expect(page).not_to have_content 'タスク5'
      end
      it 'descriptionによるあいまい検索が正常に機能すること' do
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
    describe '3.開始期限と終了期限による検索ができること' do
      it '開始期限と終了期限による検索が正常に機能すること' do
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
    describe '4.開始期限、終了期限のどちらか一方だけでも検索できること' do
      it '開始期間のみによる検索が正常に機能すること' do
        visit tasks_path
        fill_in "q_deadline_gteq", with: Date.parse("2023-01-01")
        find('input[type="submit"]').click
        expect(page).to have_content 'タスク3'
        expect(page).to have_content 'タスク4'
        expect(page).to have_content 'タスク5'
        expect(page).not_to have_content 'タスク1'
        expect(page).not_to have_content 'タスク2'
      end
      it '終了期間のみによる検索が正常に機能すること' do
        visit tasks_path
        fill_in "q_deadline_lteq", with: Date.parse("2023-01-01")
        find('input[type="submit"]').click
        expect(page).to have_content 'タスク1'
        expect(page).to have_content 'タスク2'
        expect(page).to have_content 'タスク3'
        expect(page).not_to have_content 'タスク5'
        expect(page).not_to have_content 'タスク4'
      end
    end
    describe '5.期間の検索範囲は開始期限以上、終了期限以下であること' do
      it '_gteqと_lteqが使用されていること' do
        visit tasks_path
        expect(page).to have_selector '#q_deadline_gteq'
        expect(page).to have_selector '#q_deadline_lteq'
      end
    end
    describe '6.ステータスによる検索機能がラジオボタンで実装されていること' do
      it 'ラジオボタンが存在すること' do
        visit tasks_path
        expect(page).to have_selector 'input[type="radio"]'
      end
    end
    describe '7.ステータスによる検索が正常に機能する' do
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
    describe '8.デフォルトで、"指定なし"のラジオボタンが選択されている' do
      it '#q_status_eq_の要素がチェックされていること' do
        visit tasks_path
        expect(find("#q_status_eq_")).to be_checked
      end
    end
    describe '9.キーワード、期限、ステータスの複数の条件による検索が正常に機能すること' do
      it 'キーワードと開始期限による検索が正常に機能する' do
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
      it 'キーワードと開始期限による検索が正常に機能する' do
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
      it 'キーワードと開始期限とステータスによる検索が正常に機能する' do
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
      it 'キーワードと開始期間とステータスによる検索が正常に機能する' do
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
    describe '10.期間に対し、ソート機能が実装されていること' do
      it 'ソートリンクをクリックすると降順に、もう一度クリックすると昇順にタスクが表示される' do
        visit tasks_path
        find('.sort_link').click
        sleep 0.5
        task_list = all('tr')
        expect(task_list[1]).to have_content 'タスク1'
        expect(task_list[2]).to have_content 'タスク2'
        expect(task_list[3]).to have_content 'タスク3'
        expect(task_list[4]).to have_content 'タスク4'
        expect(task_list[5]).to have_content 'タスク5'
        find('.sort_link').click
        sleep 0.5
        task_list = all('tr')
        expect(task_list[1]).to have_content 'タスク5'
        expect(task_list[2]).to have_content 'タスク4'
        expect(task_list[3]).to have_content 'タスク3'
        expect(task_list[4]).to have_content 'タスク2'
        expect(task_list[5]).to have_content 'タスク1'
      end
      it '開始期間とステータスによる検索後のソートが正常に機能する' do
        visit tasks_path
        fill_in "q_deadline_gteq", with: Date.parse("2021-01-01")
        choose 'q_status_eq_1'
        find('input[type="submit"]').click
        find('.sort_link').click
        sleep 0.5
        task_list = all('tr')
        expect(task_list[1]).to have_content 'タスク2'
        expect(task_list[2]).to have_content 'タスク5'
        find('.sort_link').click
        sleep 0.5
        task_list = all('tr')
        expect(task_list[1]).to have_content 'タスク5'
        expect(task_list[2]).to have_content 'タスク2'
      end
    end
end
