class Price < ApplicationRecord
  belongs_to :saveitem
  belongs_to :user
  validates :price, presence: true

  def self.save_price(user, item, price)
    user.prices.create(
      saveitem: item,
      price: price
    )
  end

  def self.set_datas(user, item)
    prices = self.where(user: user, saveitem: item)
    datas = []
    prices.each do |price|
      data = ["#{price.created_at.strftime('%Y/%m/%d')}",price.price]
      datas.push(data)
    end
    return datas
  end

  def self.get_price(item, user)
    return self.order(updated_at: :desc).find_by(user: user, saveitem: item).price
  end
end
