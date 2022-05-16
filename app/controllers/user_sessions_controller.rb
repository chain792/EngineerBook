class UserSessionsController < ApplicationController
  skip_before_action :require_login, only: %i[new create]

  def new
    # 自分で「ログイン or 新規登録」ボタンを押下した場合はsession[:return_to_url]を削除する
    session[:return_to_url] = nil if params[:return].nil?
  end

  def create 
    @user = login(params[:email], params[:password])
    if @user
      redirect_back_or_to profile_path, success: t('.success')
    else
      flash.now[:danger] = t('.fail')
      render 'new'
    end
  end

  def destroy
    logout
    redirect_to root_path, success: t('.success')
  end
end
