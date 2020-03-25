class Post < ApplicationRecord
  belongs_to :user
  default_scope -> { order(created_at: :desc) } #ラムダ式、降順にする
  validates :user_id, presence: true
  validates :content, presence: true
end
