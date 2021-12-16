require 'rails_helper'

RSpec.feature "saveitems", type: :feature do
    include GoogleOauthMockHelper
    scenario "ログイン後、検索し保存する" do
        visit root_path
        
        OmniAuth.config.mock_auth[:google_oauth2] = nil
        Rails.application.env_config['omniauth.auth'] = google_oauth_mock()
        click_link "Googleアカウントでログイン"

        expect(page).to have_current_path "/saveitems"

        click_link "商品検索"
        expect(page).to have_current_path "/products"

        fill_in "keyword", with: "【エントリーでポイントUP】【最大5万円クーポン配布中】 【新品】日本マテリアル 24金 純金 インゴット 50g ペンダントトップ 枠脱着可能 ゴールドバー K24(50459)"
        click_button "検索"
        expect(page).to have_content "保存"
        expect(page).to have_selector "tbody"

        click_on "保存"
        expect(page).to have_current_path "/saveitems"
        expect(page).to have_content "商品情報を保存しました。"

        click_link "価格チェック"
        expect(page).to have_content "削除"
    end

    scenario "ログイン後、検索し保存後、削除する。" do
        visit root_path
        
        OmniAuth.config.mock_auth[:google_oauth2] = nil
        Rails.application.env_config['omniauth.auth'] = google_oauth_mock()
        click_link "Googleアカウントでログイン"

        expect(page).to have_current_path "/saveitems"

        click_link "商品検索"
        expect(page).to have_current_path "/products"

        fill_in "keyword", with: "【エントリーでポイントUP】【最大5万円クーポン配布中】 【新品】日本マテリアル 24金 純金 インゴット 50g ペンダントトップ 枠脱着可能 ゴールドバー K24(50459)"
        click_button "検索"
        expect(page).to have_content "保存"
        expect(page).to have_selector "tbody"

        expect {
            click_link "保存"
            expect(page).to have_current_path "/saveitems"
            expect(page).to have_content "商品情報を保存しました。"
    }.to change(Saveitem, :count).by(1)
        

        click_link "価格チェック"
        expect(page).to have_content "削除"
        
        expect {
            click_link "削除"
        }.to change(Saveitem, :count).by(-1)
    end

    scenario "ログイン後正常にログアウトできる。" do
        visit root_path
        
        OmniAuth.config.mock_auth[:google_oauth2] = nil
        Rails.application.env_config['omniauth.auth'] = google_oauth_mock()
        click_link "Googleアカウントでログイン"

        expect(page).to have_current_path "/saveitems"
        expect(page).to have_content "John Doe"
        expect(page).to have_content "ログインしました。"

        click_link "ログアウト"
        expect(page).to have_current_path "/"
        expect(page).to have_content "ログアウトしました。"
    end
end