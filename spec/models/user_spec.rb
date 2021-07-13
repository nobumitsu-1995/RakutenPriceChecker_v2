require 'rails_helper'

RSpec.describe User, type: :model do
  describe "validationチェック" do
    context "有効な条件" do
      it ":uid, :nameがあれば有効なこと" do
        expect(User.new(uid: rand(1..300000), name: "test")).to be_valid
      end
    end
    context "無効な条件" do
      it ":uidが無ければ無効なこと" do
        user = User.new(uid: nil, name: "test")
        user.valid?
        expect(user.errors[:uid]).to include("can't be blank")
      end
      it ":nameが無ければ無効なこと" do
        user = User.new(uid: rand(1..300000), name: "")
        user.valid?
        expect(user.errors[:name]).to include("can't be blank")
      end
      it ":uidが重複する時無効なこと" do
        User.create(uid: 1, name: "test")
        user = User.new(uid: 1, name: "test")
        user.valid?
        expect(user.errors[:uid]).to include("has already been taken")
      end
    end
  end
  describe "find_or_create_accountの機能" do
    it "登録されていない:uidでログインした時、新しいuserを作成する" do
      hash = {uid: rand(1..300000), info: {name: "test", image: "test"}}
      expect{User.find_or_create_account(hash)}.to change(User, :count).by(1)
    end
    it "登録済みの:uidでログインした時は、userは作成されない" do
      hash = {uid: rand(1..300000), info: {name: "test", image: "test"}}
      User.find_or_create_account(hash)
      expect{User.find_or_create_account(hash)}.to change(User, :count).by(0)
    end
  end
end
