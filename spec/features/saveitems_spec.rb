require 'rails_helper'

RSpec.feature "saveitems", type: :feature do
    scenario "ログイン後、検索し保存する", js: true do
        visit root_path
        click_link "Googleアカウントでログイン"

        expect(page).to have_current_path "/saveitems"

        click_link "商品検索"
        expect(page).to have_current_path "/products"

        fill_in "keyword", with: "rails"
        click_button "検索"
        expect(page).to have_content "保存"
        expect(page).to have_selector "tbody"

        click_link "保存", match: :first
        expect(page).to have_current_path "/saveitems"
        expect(page).to have_content "商品情報を保存しました。"

        click_link "価格チェック"
        expect(page).to have_current_path "/saveitems/1"
        expect(page).to have_content "削除"
    end

    scenario "ログイン後、検索し保存後、削除する。" do

    end
end