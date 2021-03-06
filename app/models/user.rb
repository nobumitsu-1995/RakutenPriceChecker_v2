class User < ApplicationRecord
  validates :name, presence: true
  validates :uid, presence: true, uniqueness: true
  has_many :saveitems, dependent: :delete_all
  has_many :prices, dependent: :delete_all

  def self.find_or_create_account(auth)
    uid = auth[:uid]
    name = auth[:info][:name]

    User.find_or_create_by(uid: uid, name: name) do |user|
      user.name = name
      user.uid = uid
    end
  end
end
