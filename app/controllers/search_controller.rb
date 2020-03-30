class SearchController < ApplicationController

  def search
    if params[:content]
      if params[:model] == "user"
        @users = User.where("name LIKE ?", "%#{params[:content]}%")
        @users = @users.paginate(page: params[:page], per_page: 5)
      elsif params[:model] == "post"
        @posts = Post.where("content LIKE ?", "%#{params[:content]}%")
        @posts = @posts.paginate(page: params[:page], per_page: 5)
      end
    end
  end

end

