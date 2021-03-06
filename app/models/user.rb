class User < ApplicationRecord
    mount_uploader :image, ImageUploader
    before_save { self.email = email.downcase }

    has_many :posts, dependent: :destroy
    has_many :comments, dependent: :destroy
    has_many :relationships, dependent: :destroy

    #架空のfollowingクラス(モデル)を作成、throughで中間テーブルはrelationshipsと設定
    #sourceでrelationshipsテーブルのfollow_idを参考に、followingsモデルにアクセス
    #user.followingsと打つだけで、userが中間テーブルrelationshipsを取得し、
    #その1つ1つのrelationshipのfollow_idからフォローしているUser達を取得している
    has_many :followings, through: :relationships, source: :follow, dependent: :destroy

    #「has_many :relaitonships」の逆方向、reverse_of_relationshipsという架空のテーブル
    #class_name:でrelationsipモデルの事と設定し、relaitonshipsテーブルにアクセスする時、follow_idを入口とする
    has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: 'follow_id', dependent: :destroy

     #架空のfollowersクラス
    has_many :followers, through: :reverse_of_relationships, source: :user, dependent: :destroy

    has_many :likes, dependent: :destroy
    # 「liked_posts」によってuserがどの投稿をいいねしているのか取得できるようになる
    has_many :liked_posts, through: :likes, source: :post

    #仮想の属性の作成
    attr_accessor :remember_token

    VALID_UNIQUE_NAME_REGEX = /\A[a-z0-9_]+\z/i
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :name,   presence: true, length: { maximum: 50 }
    validates :unique_name, presence: true, length: { in: 2..15 }, format: { with: VALID_UNIQUE_NAME_REGEX },
                            uniqueness: { case_sensitive: false }
    validates :email,  presence: true, length: { maximum: 255 }, uniqueness: { case_sensitive: false },
                       format: { with: VALID_EMAIL_REGEX }
    #セキュアにハッシュ化したパスワードをpassword_digestに保存、仮想のpassword属性が自動で作成される
    has_secure_password
    validates :password, presence: true, length: { minimum: 8 }, allow_nil: true
    validates :profile, length: { maximum: 100 }

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

    def authenticated?(remember_token)
        BCrypt::Password.new(remember_digest).is_password?(remember_token)
    end

    # 記憶ダイジェストをnilに更新し、ユーザーのログイン情報を破棄
    def forget
        update_attribute(:remember_digest, nil)
    end

    #フォローするメソッド
    def follow(other_user)
        #フォローしようとしている other_user が自分自身ではないかを検証
        unless self == other_user
        self.relationships.find_or_create_by(follow_id: other_user.id)
        end
    end

    #フォロー解除
    def unfollow(other_user)
        relationship = self.relationships.find_by(follow_id: other_user.id)
        relationship.destroy if relationship
    end

    def following?(other_user)
        self.followings.include?(other_user)
    end

    private

end