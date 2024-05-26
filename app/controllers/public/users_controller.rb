class Public::UsersController < ApplicationController
  before_action :authenticate_user, only: [:edit, :update, :mypage]
  
  def show
    @user = User.find(params[:id])
    @posts = @user.posts
  end

  def index
    @users = User.page(params[:page])
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to public_my_page_path
    else
      @user = current_user
      render :edit
    end
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
  
  def authenticate_user
    unless current_user
      flash[:notice] = "ログインしてください"
      redirect_to new_user_session_path
    end
  end
  
  
  
end
