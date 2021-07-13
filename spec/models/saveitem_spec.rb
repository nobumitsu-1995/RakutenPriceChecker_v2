require 'rails_helper'

RSpec.describe Saveitem, type: :model do
  describe "validationチェック" do
    before do
      @user = User.create(uid: 1, name: "test")
    end
    context "有効な条件" do
      it ":item_code, :image_url, :url, :name, :user_idがある時有効であること" do
        expect(@user.saveitems.new(item_code: rand(1..30000), image_url: "http://example.com", url: "http://example/item.com", name: "test")).to be_valid
      end
    end
    context "無効な条件" do
      it ":item_codeがない時、無効なこと" do
        item = @user.saveitems.new(item_code: nil, image_url: "http://example.com", url: "http://example/item.com", name: "test")
        item.valid?
        expect(item.errors[:item_code]).to include("can't be blank")
      end
      it ":item_codeが重複する時、無効なこと" do

      end
      it ":image_urlがない時、無効なこと" do
        item = @user.saveitems.new(item_code: rand(1..30000), image_url: "", url: "http://example/item.com", name: "test")
        item.valid?
        expect(item.errors[:image_url]).to include("can't be blank")
      end
      it ":urlがない時、無効なこと" do
        item = @user.saveitems.new(item_code: rand(1..30000), image_url: "http://example.com", url: "", name: "test")
        item.valid?
        expect(item.errors[:url]).to include("can't be blank")
      end
      it ":nameがない時、無効なこと" do
        item = @user.saveitems.new(item_code: rand(1..30000), image_url: "http://example.com", url: "http://example/item.com", name: "")
        item.valid?
        expect(item.errors[:name]).to include("can't be blank")
      end
      it ":user_idがない時、無効なこと" do
        item = Saveitem.new(item_code: rand(1..30000), image_url: "http://example.com", url: "http://example/item.com", name: "test")
        item.valid?
        expect(item.errors[:user_id]).to include("can't be blank")
      end
    end
  end
end
