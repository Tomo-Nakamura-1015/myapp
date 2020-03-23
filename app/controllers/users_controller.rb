class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :destroy, :update, :index, :show]

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      redirect_to @user, notice: "登録完了！ようこそ！"
    else
      flash[:alert] = "ぴえん"
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to root_path, notice: "編集完了！"
    else
      flash[:alert] = "ぴえん"
      render :edit
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:alert] = "ぴえん"
    redirect_to root_path
  end

  private
   def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
   end

end
