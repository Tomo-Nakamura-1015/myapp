class User < ApplicationRecord
  validates :name,   presence: true
  validates :email,  presence: true
  
#   セキュアにハッシュ化したパスワードをpassword_digestに保存
  has_secure_password validations: true
end
