class PostsController < ApplicationController
  before_action :set_post, only:[:show,:update,:edit,:destroy]
  before_action :user_signed_in?, only:[:create, :edit, :destroy]
  #before_action :admin_user, only: :destroy #ここが問題
  #before_action :correct_user, only:[:edit, :update]
  before_action :admin_or_correct, only: [:edit, :update, :destroy]

  def home
    @posts = Post.order(created_at: :desc).paginate(:page => params[:page], :per_page => 6)#最新投稿がページトップに来るようにFIXアーサ
    @sort_likes = Post.joins(:likes).group(:id).order("count(*) desc").limit(6) #Likeの多い順に投稿を表示する
    client = Instagram.client(access_token: "1987747396.9cc0eef.b0bb30438f034e3e91d1890fe7e5ca0f")
    @instagramPosts = client.user_recent_media("1987747396", {:count => 6})
  end

  def new
  @post = Post.new
  @post_attachment = @post.post_attachments.build

  end

  def show
  commontator_thread_show(@post)
  @post_attachments = @post.post_attachments.all
  @ogImage = @post.post_attachments.first.picture
  @ogDescription = @post.content.truncate(140, separator: '.')
  end

  def index
  @posts = Post.order(created_at: :desc).paginate(:page => params[:page], :per_page => 18)#最新投稿がページトップに来るようにFIXアーサ
  end

  def edit

  end


  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      ##@post_attachments = PostAttachment.find_by_post_id(@post.id) --> this can be use in edit
      ##if params[:post_attachments]['picture'].length+ @post_attachment.length <= 5
       if params[:post_attachments]['picture'].length <= 3#(より小さいか等しい)
         params[:post_attachments]['picture'].each do |a|
            @post_attachment = @post.post_attachments.create!(:picture => a, :post_id => @post.id)
         end
       elsif params[:post_attachments]['picture'].length > 3#(より大きい場合)
         redirect_to new_post_path, notice: "You can only upload 3 picture maximum."
         return false
       end
       redirect_to @post, notice: "Post Saved"
    else
     if params[:post_attachments]['picture'].length > 3
        @post.errors[:base] << "You can only upload 3 picture maximum"
          @post.post_attachments.build
     end
      @post.post_attachments.build
     render :new
   end
  end

  def update

    if @post.update(post_params)

      if params[:post_attachments] && params[:post_attachments]['picture'].length <=3
           # 存在する post_attachmentsを削除
           @post.post_attachments.delete_all
           # 新しいのを作成
           params[:post_attachments]['picture'].each do |a|
             @post_attachment = @post.post_attachments.create!(:picture => a, :post_id => @post.id)
           end
       elsif params[:post_attachments]['picture'].length > 3#(より大きい場合)
         redirect_to edit_post_path, notice: "You can upload 3 picture maximum"
         return false
       end
      redirect_to @post, notice: "Post Updated"
    else
      render :edit
    end
  end

  def destroy
    Post.delete_all(id: params[:id])
    redirect_to posts_path, notice: "Deleted"
  end

  def popular
    @posts = Post.joins(:likes).group(:id).order("count(*) desc").paginate(:page => params[:page], :per_page => 18)
    # @posts = Post.joins(:likes).group(:post_id).order("count(*) desc").paginate(:page => params[:page], :per_page => 18)
    # @posts = Post.joins(:likes).group("posts.id").order("count_posts_id DESC").limit(10).count("posts.id").keys #いいね順の投稿を取得
  end

  def aoyama
    @posts = Category.where(id: 3).first.posts.paginate(:page => params[:page], :per_page => 18).order(created_at: :desc) #カテゴリーAoyamaの投稿を取得
  end

  def shibuya
    @posts = Category.where(id: 2).first.posts.paginate(:page => params[:page], :per_page => 18).order(created_at: :desc) #カテゴリーShibuyaの投稿を取得
  end

  def ginza
    @posts = Category.where(id: 1).first.posts.paginate(:page => params[:page], :per_page => 18).order(created_at: :desc) #カテゴリーGinzaの投稿を取得
  end

  def other
    @posts = Category.where(id: 5).first.posts.paginate(:page => params[:page], :per_page => 18).order(created_at: :desc) #カテゴリーOthersの投稿を取得
  end

  def product
    @posts = Category.where(id: 4).first.posts.paginate(:page => params[:page], :per_page => 18).order(created_at: :desc) #カテゴリーProductsの投稿を取得
  end

  private


  def set_post
    @post = Post.find(params[:id])
    # @ogImage = @post.picture.first.url
    @ogTitle = @post.title
    @ogDescription = @post.content.truncate(120, separator: '.')
  end
#ストロングパラメーター
  def post_params
    params.require(:post).permit(:title,:content,:user_id,:category_id,:address, post_attachments_attributes: [:id, :post_id, :picture, :_destroy])
  end

  def admin_user
    current_user.admin?
    #redirect_to(root_url)unless current_user.admin? 2/10 ここをコメントアウトした
    #unless current_user.admin?
      #redirect_to root_path, notice:"Not allowed"
    #end
  end

  def correct_user
    @post.user == current_user
    #post = Post.find(params[:id])
    #if current_user.id != post.user.id
      #redirect_to root_path, notice: "Please login"
    #end
  end

  def admin_or_correct
   redirect_to(root_url) unless admin_user || correct_user
  end
end
