class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  before_action :configure_permitted_parameters, if: :devise_controller?
  protect_from_forgery with: :exception
  after_filter  :store_location #ログインする直前のページにリダイレクト 11/20 arthur
  # エラーメッセージの処理5/21
  rescue_from ActiveRecord::RecordNotFound, with: :render_404
  rescue_from ActionController::RoutingError, with: :render_404
  rescue_from Exception, with: :render_500

  def store_location #ログインする直前のページにリダイレクト 11/20 arthur
    if (request.fullpath != new_user_registration_path &&
        request.fullpath != new_user_session_path &&
        request.fullpath !~ Regexp.new("\\A/users/password.*\\z") &&
        !request.xhr?)
      session[:previous_url] = request.fullpath
    end
  end

  def after_sign_in_path_for(resource)#ログインする直前のページにリダイレクト 11/20 arthur
    if (session[:previous_url] == root_path)
      super
    else
      session[:previous_url] || root_path
    end
  end

  # エラーメッセージ処理
  def render_404
    render template: 'errors/error_404', status: 404, layout: 'application', content_type: 'text/html'
  end

  def render_500
    render template: 'errors/error_500', status: 500, layout: 'application', content_type: 'text/html'
  end

  private
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    end

    def user_signed_in #ログイン済みユーザーかを確認する　11/19 arthur
      unless user_signed_in?
        redirect_to new_user_session_path, notice: "ログインして下さい" #ログイン画面にリダイレクト
      end
    end


end
