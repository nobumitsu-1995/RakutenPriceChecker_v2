class AddUserIdToSaveitems < ActiveRecord::Migration[6.1]
  def change
    add_reference :saveitems, :user, null: false, foreign_key: true
  end
end
