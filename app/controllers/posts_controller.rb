class PostsController < ApplicationController

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
      flash[:denger] = "ぴえん"
    end
  end

  def destroy
  end

  private

  def post_params
    params.require(:post).permit(:content)
  end

end
