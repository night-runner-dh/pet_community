class Public::PostsController < ApplicationController
  before_action :is_matching_login_user, :require_login, only: [:edit, :update]
  before_action :require_login, only: [:new]

  
  def new
    @post = Post.new
  end

  def index
    @post = Post.page(params[:page]).per(5)
  end

  def show
    @post = Post.find(params[:id])
    @post_comment = PostComment.new
  end
  
  def my_posts
    @posts = Post.where(user_id: current_user.id).page(params[:page]).per(5)
  end
  
  def image_index
    @posts = Post.all
  end
  
  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    
    if @post.save
      flash[:notice] = "投稿しました。"
      redirect_to root_path, notice: "投稿しました。"
    else
      flash[:alert] = "投稿に失敗しました。"
      @posts = Post.all
      flash[:redirect] = new_public_post_path
      render :"public/posts/new"
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to public_post_path(@post), notice: "編集に成功しました。"
    else
      @post = Post.find(params[:id])
      flash[:alert] = "編集に失敗しました。"  # バリデーションメッセージをセット
      render :edit
    end
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
  
  private

  def post_params
    params.require(:post).permit(:title, :body, :image)
  end
  
  def is_matching_login_user
    @post = Post.find(params[:id])
    unless current_user && @post.user.id == current_user.id
    redirect_to root_path
    end
  end
  
  def require_login
    unless current_user
      redirect_to root_path
    end
  end
  
end
