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
      redirect_to root_url, notice: "おかえり！"
    else
      flash[:alert] = "ぴえん"
      render 'new'
    end
  end

  def destroy
# ヘルパーで定義されたlog_outメソッドで削除、logged_in?メソッドでログイン中か確認
    log_out if logged_in?
    flash[:alert] = "ぴえん"
    redirect_to root_url
  end
end
