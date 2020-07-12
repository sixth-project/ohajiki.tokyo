class AddColumnsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :uid, :string
    add_column :users, :provider, :string
    add_column :users, :image_url, :text
    add_column :users, :nickname, :string
    add_column :users, :token, :string
  end
end
