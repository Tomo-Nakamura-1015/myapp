class User < ApplicationRecord
  validates :name,   presence: true, length: { maximum: 50 }
  validates :email,  presence: true, uniqueness: true

#   セキュアにハッシュ化したパスワードをpassword_digestに保存
  has_secure_password validations: true
end
