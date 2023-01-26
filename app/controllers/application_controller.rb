class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  before_action :login_required

  private

  def login_required
    redirect_to new_session_path, alert: 'ログインしてください' unless current_user
  end

  def logged_in
    redirect_to tasks_path, alert: 'ログイン中は新規登録画面にはアクセスできません' if current_user
  end

  def admin_login_required
    unless current_user && current_user.admin?
      redirect_to tasks_path, alert: '管理者権限がないユーザーは管理者画面にはアクセスできません'
    end
  end
end