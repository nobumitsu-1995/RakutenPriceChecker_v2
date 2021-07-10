class SessionsController < ApplicationController
  def create
    user = User.find_or_create_account(request.env["omniauth.auth"])
    session[:user_id] = user.id
    redirect_to saveitems_path, notice: "ログインしました。"
  end

  def destroy
    reset_session
    redirect_to root_path, notice: "ログアウトしました。"
  end
end
