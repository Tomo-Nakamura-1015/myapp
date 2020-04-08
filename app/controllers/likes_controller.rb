class LikesController < ApplicationController

  def create
    @like = current_user.likes.create(post_id: params[:post_id])
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @like = Like.find_by(post_id: params[:post_id], user_id: current_user.id)
    @like.destroy
    redirect_back(fallback_location: root_path)
  end

#   <% if post.liked?(current_user)%>
#   <%= button_to 'いいねを取り消す', post_like_path(post), method: :delete %>
# <% else %>
#   <%= button_to 'いいね', post_likes_path(post) %>
# <% end %>
end
