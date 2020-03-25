class User < ApplicationRecord
    has_many :posts, dependent: :destroy #ユーザが削除されると一緒にpostも削除される
    attr_accessor :remember_token #仮想の属性の作成

    validates :name,   presence: true, length: { maximum: 50 }
    validates :email,  presence: true, uniqueness: true, length: { maximum: 255 }
    #セキュアにハッシュ化したパスワードをpassword_digestに保存、仮想のpassword属性が自動で作成される
    has_secure_password
    validates :password, presence: true, length: { minimum: 6}

    #渡された文字列のハッシュ値を返す
    def User.digest(string)
        cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                    BCrypt::Engine.cost
        BCrypt::Password.create(string, cost: cost)
    end

    #ライブラリの[SecureRandom]モジュール[urlsafe_base64]によってランダムなトークンを返す
    def User.new_token
        SecureRandom.urlsafe_base64
    end

    def remember
        self.remember_token = User.new_token
        #[update_attribute]を使って記憶ダイジェストの更新、バリデーションを素通りする
        update_attribute(:remember_digest, User.digest(remember_token))
    end

    # 
    def authenticated?(remember_token)
        BCrypt::Password.new(remember_digest).is_password?(remember_token)
    end

    # 記憶ダイジェストをnilに更新し、ユーザーのログイン情報を破棄
    def forget
        update_attribute(:remember_digest, nil)
    end

end