module SessionsHelper

        # ブラウザのcookieに、ハッシュ化したユーザidで保存、ログインする
    def log_in(user)
        session[:user_id] = user.id
    end

    # 永続的セッションの破棄
    def forget(user)
        #userモデルで定義したforgetを呼んでからcookiesの削除
        user.forget
        cookies.delete(:user_id)
        cookies.delete(:remember_token)
    end

    # ユーザーIDと記憶トークンの永続cookiesを作成
    def remember(user)
        user.remember
        cookies.permanent.signed[:user_id] = user.id
        cookies.permanent[:remember_token] = user.remember_token
    end

    #現在ログインしているユーザ
  def current_user
    #(ユーザーIDにユーザーIDのセッションを代入した結果)ユーザーIDのセッションが存在すれば
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      if user && user.authenticated?(cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end

    #受け取ったユーザーがログイン中のユーザーと一致するか
    def current_user?(user)
        user == current_user
    end

    # 現在のユーザがログインしているかを判別true,false
    def logged_in?
        !current_user.nil?
    end

    # ブラウザのcookieに保存されたユーザidの削除
    def log_out
        forget(current_user)
        session.delete(:user_id)
        @current_user = nil
    end

end
