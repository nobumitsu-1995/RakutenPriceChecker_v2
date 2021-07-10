class Saveitem < ApplicationRecord
  belongs_to :user
  has_many :prices, dependent: :delete_all
  validates :item_code, presence: true, uniqueness: true
  validates :image_url, presence: true
  validates :url, presence: true
  validates :name, presence: true

end
