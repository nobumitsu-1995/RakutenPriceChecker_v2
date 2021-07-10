class CreateSaveitems < ActiveRecord::Migration[6.1]
  def change
    create_table :saveitems do |t|
      t.string :item_code, null: false
      t.string :image_url, null: false
      t.string :url, null: false
      t.string :name, null: false

      t.timestamps
    end
  end
end
