class PostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy, :new]

  def new
    @post = Post.new
  end

  def index
    @post  = current_user.posts.build
    @posts = Post.paginate(page: params[:page], per_page: 5)
    @like = Like.new
  end

  def show
    @post = Post.find(params[:id])
    @like = Like.new
    @comment = Comment.new
    @comments = @post.comments
  end

  def create
    @post = current_user.posts.new(post_params)
     # @から始まり、半角英数またはアンダースコアが5回以上、15回以下の繰り返しにマッチ。大文字、小文字区別しない。
    re = /@([0-9a-z_]{5,15})/i
    # 投稿文に対して上記正規表現をマッチング
    @post.content.match(re)
    # $1は正規表現の中の丸かっこの表現にマッチする内容が入る(つまりここでは一意ユーザ名)
    # マッチするものが無ければnil
    if $1
      # マッチした一意ユーザ名は小文字にしてから検索
      reply_user = User.find_by(unique_name: $1.downcase)
      # 一意ユーザ名を持つ返信先ユーザが存在すればin_reply_toカラムにそのユーザIDをセット
      @post.in_reply_to = reply_user.id if reply_user
    end
    if @post.save
      flash[:success] = "投稿完了！"
      redirect_to post_path(@post)
    else
      @feed_items = []
      flash[:danger] = "ぴえん"
      redirect_to current_user
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
