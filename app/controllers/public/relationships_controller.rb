class Public::RelationshipsController < ApplicationController
     before_action :authenticate_user!
  
  def create
    user = User.find(params[:user_id])
    current_user.follow(user)
    @user = User.find(params[:user_id])
  end
  
  def destroy
    user = User.find(params[:user_id])
    current_user.unfollow(user)
    @user = User.find(params[:user_id])
  end
  
  def followings
    user = User.find(params[:user_id])
    @users = user.followings.page(params[:page]).per(10)
  end
  
  def followers
    user = User.find(params[:user_id])
    @users = user.followers.page(params[:page]).per(10)
  end
end
