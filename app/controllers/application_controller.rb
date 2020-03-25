class ApplicationController < ActionController::Base

# ヘルパーの読み込み、全てのページで使えるように
    include SessionsHelper

# ログイン済みか確認、していなければリダイレクト、全てのページで使えるようにここで定義
    def logged_in_user
        unless logged_in?
            flash[:danger] = "ログインしてね"
          redirect_to login_url
        end
    end
end
