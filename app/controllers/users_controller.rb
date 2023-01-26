class UsersController < ApplicationController
  skip_before_action :login_required, only: [:new, :create]
  before_action :logged_in, only: :new

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "ログインしました"
      redirect_to user_path(@user.id), notice: "登録しました"
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to tasks_path, notice: "他人の情報にはアクセスできません"
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation, :admin)
  end
end
