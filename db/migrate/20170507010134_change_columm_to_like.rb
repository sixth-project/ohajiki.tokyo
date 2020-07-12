class ChangeColummToLike < ActiveRecord::Migration
  def change
    drop_table:likes
    create_table :likes, id: false do |t|
      t.integer :user_id
      t.integer :post_id

      t.timestamps null: false
    end
  end
end
