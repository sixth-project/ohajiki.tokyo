class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy, :like_posts]
  before_action :user_signed_in, only: [:edit, :update] #ユーザープロフ編集にはログインが必要。11/20 arthur
  before_action :correct_user, only: [:edit, :update] #正しいユーザーかの確認 11/20 arthur
  before_action :sns_user, only: [:edit, :update] #snsユーザーの編集禁止
  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show

    @posts = @user.posts #11/19 Mypostsを表示
  end



  def create #avatarの条件分岐
    @user = User.new(user_params)
    file = params[:user][:avatar]
    @user.set_image(file)

  end

  # GET /users/new
  # def new
  #   @user = User.new
  # end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  # def create
  #   @user = User.new(user_params)

  #   respond_to do |format|
  #     if @user.save
  #       format.html { redirect_to @user, notice: 'User was successfully created.' }
  #       format.json { render :show, status: :created, location: @user }
  #     else
  #       format.html { render :new }
  #       format.json { render json: @user.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    file = params[:user][:avatar]
    @user.set_image(file)

    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  # def destroy
  #   @user.destroy
  #   respond_to do |format|
  #     format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
  #     format.json { head :no_content }
  #   end
  # end
  def like_posts
    @posts = @user.like_posts
    @title = "My favorite"
    render '_user_like_posts'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :email)
    end

    #正しいユーザーかどうかを確認する 11/20 arthur
    def correct_user
      user = User.find(params[:id])
      if current_user != user
        redirect_to root_path, alert: 'Not allowed,許可されていないページです'
      end
    end

    def sns_user
      user = User.find(params[:id])
      if !user.provider.nil?
        redirect_to root_path, alert: 'Not allowed,許可されていないページです'
      end
    end



end
