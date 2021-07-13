require 'rails_helper'

RSpec.describe Price, type: :model do
  describe "validationチェック" do
    before do
      @user = User.create(uid: 1, name: "test")
      @saveitem = @user.saveitems.create(item_code: rand(1..30000), image_url: "http://example.com", url: "http://example/item.com", name: "test")
    end
    context "有効な条件" do
      it ":priceがある時有効であること" do
        expect(@user.prices.new(saveitem: @saveitem, price: rand(1000..10000))).to be_valid
      end
    end
    context "無効な条件" do
      it ":priceがない時、無効なこと" do
        price = @user.prices.new(saveitem: @saveitem, price: nil)
        price.valid?
        expect(price.errors[:price]).to include("can't be blank")
      end
      it ":user_idがない時、無効なこと" do
        price = Price.new(saveitem: @saveitem, price: rand(1000..10000))
        price.valid?
        expect(price.errors[:user_id]).to include("can't be blank")
      end
      it ":saveitem_idがない時、無効なこと" do
        price = @user.prices.new(saveitem: nil, price: rand(1000..10000))
        price.valid?
        expect(price.errors[:saveitem_id]).to include("can't be blank")
      end
    end
  end
  describe "メソッド機能テスト" do
    before do
      @user = User.create(uid: 1, name: "test")
      @saveitem = @user.saveitems.create(item_code: rand(1..30000), image_url: "http://example.com", url: "http://example/item.com", name: "test")
    end
    it "Priceテーブルにレコードが正常に保存される。" do
      expect{Price.save_price(@user, @saveitem, rand(1..1000))}.to change(Price, :count).by(1)
    end
    it "日付が正常に代入され、出力できる。" do
      price = Price.save_price(@user, @saveitem, 100)
      @datas = Price.set_datas(@user, @saveitem)
      expect(@datas[0][1]).to eq(100)
    end
    it "一番新しい:priceデータが出力される。" do
      Price.save_price(@user, @saveitem, 100)
      Price.save_price(@user, @saveitem, 200)
      Price.save_price(@user, @saveitem, 300)
      expect(Price.get_price(@saveitem, @user)).to eq(300)
    end
  end
end
