class AddAdrressToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :address, :text
  end
end
