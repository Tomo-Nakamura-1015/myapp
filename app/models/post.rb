class Post < ApplicationRecord
  mount_uploader :image, ImageUploader
  belongs_to :user
  has_many :likes
  #「liked_users」によって投稿が誰にいいねされているのか取得できるようになる
  has_many :liked_users, through: :likes, source: :user

  default_scope -> { order(created_at: :desc) } #ラムダ式、降順にする
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }

  # Micropostsテーブルから、下記のいずれか条件の投稿を取得する
  #   自分がフォローしている人
  #   自分のポスト
  #   返信先が自分になっているポスト
  # def Post.including_replies(user_id)
  #     Post.where("user_id IN (:followings_ids)
  #               OR user_id     =   :user_id
  #               OR in_reply_to =   :user_id",
  #               followings_ids: followings_ids, user_id: user_id)
  # end
end
