class CommentsController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    @comment.user = current_user
    if @comment.save
      flash[:success] = "コメントを投稿しました"
      redirect_to post_path(@post)
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])
    if @comment.destroy
      flash[:danger] = "ぴえん"
      redirect_to post_path(@post)
    end
  end

  private
    def comment_params
      params.require(:comment).permit(:content, :post_id, :user_id)
    end
end
