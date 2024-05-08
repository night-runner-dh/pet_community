class Public::UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @posts = @user.posts
  end

  def index
    @user = User.all
  end

  def edit
    @user = current_user
  end

  def update
    user = current_user
    user.update(user_params)
    redirect_to public_my_page_path
  end

  def mypage
    @user = current_user
  end

  def unsubscribe
  end

  def withdraw
    @user=User.find(current_user.id)
    @user.update(is_active: false)
    reset_session
    flash[:notice] = "退会処理を実行いたしました"
    redirect_to root_path
  end
  
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email)
  end
  
  
  
end
