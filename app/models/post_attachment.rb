class PostAttachment < ActiveRecord::Base
  mount_uploader :picture,PictureUploader #Postsモデルに画像を追加
  belongs_to :post
end
