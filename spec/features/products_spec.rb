require 'rails_helper'

RSpec.feature "products", type: :feature do
    scenario "検索結果が表示される。" do
        visit root_path
        fill_in "keyword", with: "rails"
        click_button "検索"

        expect(page).to have_no_content "保存"
        expect(page).to have_selector "tbody"
    end
end