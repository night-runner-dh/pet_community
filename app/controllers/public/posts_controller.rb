class Public::PostsController < ApplicationController
  before_action :is_matching_login_user, :require_login, only: [:edit, :update]
  before_action :require_login, only: [:new]

  
  def new
    @post = Post.new
  end

  def index
    @post = Post.order(created_at: :desc).page(params[:page]).per(5)
    @tags = Tag.unique_tags
  end

  def show
    @post = Post.find(params[:id])
    #@comments = @post.post_comments.page(params[:page]).per(10)
    @comments = @post.post_comments.order(created_at: :desc).page(params[:page]).per(10)
    @post_comment = PostComment.new
  end
  
  def my_posts
    #@post = Post.order(created_at: :desc).page(params[:page]).per(5)
    @posts = Post.where(user_id: current_user.id).order(created_at: :desc).page(params[:page]).per(5)
  end
  
  def image_index
    @posts = Post.left_joins(:image_attachment).where.not(active_storage_attachments: { id: nil }).order(created_at: :desc).page(params[:page]).per(20)
  end
  
  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    tags = Vision.get_image_data(post_params[:image])
    if @post.save
      tags.each do |tag|
        @post.tags.create(name: tag)
      end
      flash[:notice] = "投稿しました。"
      redirect_to root_path, notice: "投稿しました。"
    else
      flash[:alert] = "投稿に失敗しました。"
      @posts = Post.all
      flash[:redirect] = new_post_path
      render :"public/posts/new"
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to post_path(@post), notice: "編集に成功しました。"
    else
      flash.now[:alert] = @post.errors.full_messages.join('<br>').html_safe # バリデーションメッセージをセット
      render :edit
    end
    #  @post = Post.find(params[:id])
    #  flash[:alert] = "編集に失敗しました。" 
    #  render :edit
  end

  def destroy
    @post = Post.find(params[:id])
    if @post.destroy
        respond_to do |format|
          format.html { redirect_to root_path, notice: "削除に成功しました。" }
          format.js   # 追加する部分
        end
    else
        respond_to do |format|
          format.html { redirect_to post_path(@post), alert: "削除に失敗しました。" }
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
