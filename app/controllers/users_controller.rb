class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :destroy, :update, :index, :show]

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.paginate(page: params[:page], per_page: 5)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      redirect_to @user, success: "登録完了！ようこそ！"
    else
      flash[:danger] = "ぴえん"
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to root_path, success: "編集完了！"
    else
      flash[:danger] = "ぴえん"
      render :edit
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:danger] = "ぴえん"
    redirect_to root_path
  end

  private
   def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :image)
   end

end
