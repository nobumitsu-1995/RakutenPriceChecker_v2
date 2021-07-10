class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :uid, null: false
      t.string :name, null: false

      t.timestamps
    end

    add_index :users, %i[uid name], unique: true
  end
end
