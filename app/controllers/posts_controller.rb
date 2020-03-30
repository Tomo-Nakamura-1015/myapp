class PostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy, :new]

  def new
    @post = Post.new
  end

  def index
    @posts = Post.paginate(page: params[:page], per_page: 5)
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = "投稿完了！"
      redirect_to current_user
    else
      flash.now[:danger] = "ぴえん"
    end
  end

  def update
  end

  def destroy
    @post = Post.find_by(params[:id])
    @post.destroy
    flash[:warning] = "削除しました"
    redirect_to current_user
  end

  private

  def post_params
    params.require(:post).permit(:content, :image)
  end

end
