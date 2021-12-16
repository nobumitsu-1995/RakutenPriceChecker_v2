require 'rails_helper'

RSpec.feature "sessions", type: :feature do
    include GoogleOauthMockHelper

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