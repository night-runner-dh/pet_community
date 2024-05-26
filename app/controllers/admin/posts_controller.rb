class Admin::PostsController < ApplicationController
  
  def index
    @post = Post.page(params[:page]).per(5)
  end
  
  def show
    @post = Post.find(params[:id])
  end

  def my_posts
   @user = User.find(params[:user_id])
  @posts = Post.where(user_id: @user.id)
  end

  def destroy
        @post = Post.find(params[:id])
    if @post.destroy
        respond_to do |format|
          format.html { redirect_to admin_posts_path, notice: "削除に成功しました。" }
          format.js   # 追加する部分
        end
    else
        respond_to do |format|
          format.html { redirect_to admin_post_path(@post), alert: "削除に失敗しました。" }
          format.js   # 追加する部分
        end
    end
  end
end
