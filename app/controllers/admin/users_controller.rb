class Admin::UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @post = Post.find_by(user_id: @user.id)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
     @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to admin_user_path(@user), notice: "会員情報を更新しました。"
    else
      render :edit
    end
  end
  
   private

    def user_params
      params.require(:user).permit(:name,
                                   :email,
                                   :is_active
                                   )
    end
  
  
end
