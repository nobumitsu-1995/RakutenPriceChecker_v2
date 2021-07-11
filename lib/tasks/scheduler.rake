desc "heroku scheduler task"
task :test_scheduler => :environment do
  puts "scheduler is works."
end

task :pricerecord_create => :environment do
  items = Saveitem.all
  items.each do |item|
    if itemprice = RakutenWebService::Ichiba::Item.search(itemCode: item.item_code).first['itemPrice']
      user = item.user
      price = Price.create(
        saveitem: item,
        user: user,
        price: itemprice
      )
      puts price
    end
  end
end
