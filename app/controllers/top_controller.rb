class TopController < ApplicationController

  def home
    if logged_in?
    @user = current_user
    @feed_items = @user.feed.paginate(page: params[:page])
    @like = Like.new
    end
  end


  
end
