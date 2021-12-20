# RakutenPriceChecker_v2について
本アプリケーションはAPIを利用した開発を学ぶために作成したWebアプリです。楽天市場に出品されている商品を検索することができ、商品情報を保存することで価格の推移を自動でグラフ化することができます。
<br><br>
以下の情報でログイン可能です。<br><br>
メールアドレス：test.user.for.portfolio@gmail.com<br>
パスワード：Testuser2021
<br>
- [アプリケーションURL](https://rakutenpricechecker.herokuapp.com/)
<img width="1000" alt="top画像" src="./public/image/rakutenpricechecker_top.png">

## 実装機能について
実装されている機能に関しては以下のようになっています。
- Googleのアカウントを利用したログイン機能。
- 楽天市場に出品されている商品情報を取得、保存する機能。
- 保存した商品の価格を1日ごとにデータベースに自動で保存し価格推移グラフを作成する機能。

1. Googleのアカウントを利用したログイン機能。
![login](https://user-images.githubusercontent.com/70850598/146776149-e88e5d95-59b3-4879-99a7-9c4def1beff7.gif)

2. 楽天市場に出品されている商品情報を取得、保存する機能。
![search](https://user-images.githubusercontent.com/70850598/146776218-9b0bd77e-29c1-4b20-951d-5ca25f204ad3.gif)

3. 保存した商品の価格を1日ごとにデータベースに自動で保存し価格推移グラフを作成する機能。<br>
以下のようなrakeタスクを作成しHeroku Schedulerで毎朝５時に実行するように設定しました。
```ruby:/lib/tasks/scheduler.rake 
task :pricerecord_create => :environment do
  items = Saveitem.all
# 登録されている全ての商品に対して以下の処理をする。
  items.each do |item|
# 商品が削除されている場合は以下の処理は実行されない。
# 商品の価格情報をAPIで取得する。
    if itemprice = RakutenWebService::Ichiba::Item.search(itemCode: item.item_code).first['itemPrice']
      user = item.user
# 取得した価格情報をPriceテーブルに保存する。
      price = Price.create(
        saveitem: item,
        user: user,
        price: itemprice
      )
      puts price
    end
  end
end
```
![price](https://user-images.githubusercontent.com/70850598/146776049-3e1a0327-9da2-443b-b545-d0c6fda98f23.gif)

## データベース設計について
データベースの設計に関しては以下のER図の通りとなります。

<img width="411" alt="ER" src="./public/image/RPC_ER.png">

## 使用した技術スタック
Bootstrap,　Ruby on Rails, PostgreSQL, Heroku, Heroku Scheduler, Google API, Rakuten API

## 使用している主なgemについて
- Rspec：　Railsの代表的なテストツールの一つ。単体テスト、統合テストを実行するために使用しました。
- Factory Bot：　テストのサンプルデータを簡単に作成することができるgem。
- omniauth-google-oauth2：　google認証機能を使用したログイン機能を実装するためのgem。
- rakuten_web_service：　Rakuten APIを使用するためのgem。
- chartkick：　グラフを描画するためのgem。
