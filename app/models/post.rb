class Post < ApplicationRecord
  mount_uploader :image, ImageUploader
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  #「liked_users」によって投稿が誰にいいねされているのか取得できるようになる
  has_many :liked_users, through: :likes, source: :user, dependent: :destroy

  default_scope -> { order(created_at: :desc) } #ラムダ式、降順にする
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }

   # マイクロポストをいいねする
   def like(user)
    likes.create(user_id: user.id)
  end

  # マイクロポストのいいねを解除する
  def unlike(user)
    likes.find_by(user_id: user.id).destroy
  end

end
