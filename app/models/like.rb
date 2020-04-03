class Like < ApplicationRecord
  belongs_to :post
  belongs_to :user
  # 「validates_uniqueness_of」によって、post_idとuser_idの組が1組しかないように
  validates_uniqueness_of :post_id, scope: :user_id
end
