class Post < ActiveRecord::Base
  belongs_to :user
  belongs_to :category #カテゴリーのリレーション11/29
  validates :user_id, presence: true
  #default_scope -> { order(created_at: :desc)} #最新ポスト順に表示
  # mount_uploader :picture,PictureUploader #Postsモデルに画像を追加
  validates :title, presence: true  #タイトルの書き込みが必要
  validates :content, presence: true #コンテンツの書き込みが必要＆文字制限255
  # validates :picture, presence: true #画像の投稿が必要
  #validates :address, presence: true #住所
  # validate  :picture_size
  validates :category_id, presence: true #カテゴリーIDが必要 11/29
  has_many :likes, dependent: :destroy #投稿が削除されたら紐づくlikesも削除する arthur 11/21
  has_many :post_attachments
  attr_accessor :post_attachment_attributes
  acts_as_commontable #コメント機能関連付け
  geocoded_by :address
  after_validation :geocode
  #validate :picture_limit #写真投稿の枚数制限！
  accepts_nested_attributes_for :post_attachments,allow_destroy: true, reject_if: :all_blank









  private

    # アップロード画像のサイズを検証する
    def picture_size
      if picture.size > 5.megabytes
        errors.add(:picture, "should be less than 5MB")
      end
    end



end
