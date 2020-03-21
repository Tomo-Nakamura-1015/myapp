module SessionsHelper

    # ブラウザのcookieに、ハッシュ化したユーザidで保存、ログインする
    def log_in(user)
        session[:user_id] = user.id
    end

    def current_user
        if session[:user_id]
            #cookieに保存されたユーザーidを元に、ユーザーの情報を取得(現在ログイン中のユーザを返す)
            @current_user ||= User.find_by(id: session[:user_id])
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
        session.delete(:user_id)
        @current_user = nil
    end

end
