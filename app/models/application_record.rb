class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def feed
    Post.where("user_id IN (:following_ids) OR user_id = :user_id",
    following_ids: following_ids, user_id: id,)
  end

  def liked?(user)
    liked_users.include?(user)
  end

end
