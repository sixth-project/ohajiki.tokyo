class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable, :omniauthable
  has_many :posts, dependent: :destroy #ユーザーと一緒にポストは破棄される
  has_many :likes
  has_many :like_posts, through: :likes, source: :post
  acts_as_commontator #コメント機能の関連づけ

  def self.find_for_oauth(auth)
    user = User.where(uid: auth.uid, provider: auth.provider).first


    if user.nil?
        user = User.new(
          uid:       auth.uid,
          name:      auth.info.name,
          image_url: auth.info.image,
          provider:  auth.provider,
          email:     User.dummy_email(auth),
          password:  Devise.friendly_token[4, 30]
        )
        user.skip_confirmation!
        user.save!
    end

    # unless user
    #   user = User.create(
    #     uid:       auth.uid,
    #     name:      auth.info.name,
    #     image_url: auth.info.image,
    #     provider:  auth.provider,
    #     email:     User.dummy_email(auth),
    #     password:  Devise.friendly_token[4, 30]
    #   )
    # end

    user
  end

  def self.find_for_google_oauth2(auth)
    user = User.where(email: auth.info.email).first

    unless user
      user = User.create(name:     auth.info.name,
                         provider: auth.provider,
                         uid:      auth.uid,
                         email:    auth.info.email,
                         token:    auth.credentials.token,
                         password: Devise.friendly_token[4, 30])
    end
    user
  end

  def set_image(file)#プロフィール画像を保存するためのインスタンスメソッド 12/12
    if !file.nil?
      file_name = file.original_filename
      File.open("public/user_avatars/#{file_name}", 'wb'){|f| f.write(file.read)}
      self.avatar = file_name
    end
  end

  private

    def self.dummy_email(auth)
      "#{auth.uid}-#{auth.provider}@example.com"
    end

end
