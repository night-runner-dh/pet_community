class Admin::PostsController < ApplicationController
  
  def index
    @post = Post.all
  end
  
  def show
    @post = Post.find(params[:id])
  end

  def edit
  end

  def destroy
        @post = Post.find(params[:id])
    if @post.destroy
        respond_to do |format|
          format.html { redirect_to public_posts_path, notice: "削除に成功しました。" }
          format.js   # 追加する部分
        end
    else
        respond_to do |format|
          format.html { redirect_to public_post_path(@post), alert: "削除に失敗しました。" }
          format.js   # 追加する部分
        end
    end
  end
end
