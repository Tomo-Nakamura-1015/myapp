class SessionsController < ApplicationController

  def new
  end

# ログインページから送信された情報を受け取りログイン処理する
  def create
    user = User.find_by(email: params[:session][:email].downcase)
# authenticate(引数の文字列がパスワードと一致するとUserオブジェクトを、間違っているとfalseを返す
    if user && user.authenticate(params[:session][:password])
# ヘルパーに定義されたlog_inメソッド
      log_in user
#もしチェックボックスの送信結果の値が１ならユーザーを記憶し、そうでないなら忘れる、三項演算子でif文を簡略化
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      flash[:info] = "おかえり！"
      redirect_to user
    else
      flash[:danger] = "ぴえん"
      redirect_to root_path
    end
  end

  def destroy
# ヘルパーで定義されたlog_outメソッドで削除、logged_in?メソッドでログイン中か確認
    log_out if logged_in?
    flash[:danger] = "ぴえん"
    redirect_to root_url
  end
end
