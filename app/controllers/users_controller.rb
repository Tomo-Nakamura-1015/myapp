class UsersController < ApplicationController
  before_action :logged_in_user, only: [:update, :index, :show]
  before_action :correct_user,   only: [:edit, :update, :destroy]

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
      flash[:success] = "登録完了！ようこそ！"
      redirect_to @user
    else
      flash[:danger] = "ぴえん"
      render 'new'
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:success] = "編集完了！"
      redirect_to @user
    else
      flash[:danger] = "ぴぴぴえん"
      render :edit
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:danger] = "ぴえん"
    redirect_to users_path
  end

  def following
    @user = User.find(params[:id])
    @users = @user.followings
    render 'show_follow'
  end

  def followers
    @user = User.find(params[:id])
    @users = @user.followers
    render 'show_follower'
  end

  private

   def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :image, :profile, :unique_name )
   end

   def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless @user == current_user
  end

  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end

end
