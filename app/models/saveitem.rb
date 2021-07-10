class Saveitem < ApplicationRecord
  belongs_to :user
  validates :item_code, presence: true
  validates :image_url, presence: true
  validates :url, presence: true
  validates :name, presence: true

end
