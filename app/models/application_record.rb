class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def feed
    Post.where("user_id IN (:following_ids) OR user_id = :user_id",
    following_ids: following_ids, user_id: id)
  end

  # ユーザーが投稿に対して、すでにいいねをしているのかどうかを判定する
  def already_liked?(post)
    self.likes.exists?(post_id: post.id)
  end

end
