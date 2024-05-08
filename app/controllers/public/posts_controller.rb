class Public::PostsController < ApplicationController
  before_action :exist_post?, only: [:show, :edit, :update, :destroy]
  
  
  def new
    @post = Post.new
  end

  def index
    @post = Post.all
  end

  def show
    @post = Post.find(params[:id])
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    
    if @post.save
      flash[:notice] = "投稿しました。."
      redirect_to public_posts_path(@post), notice: "投稿しました。"
    else
      flash[:alert] = "投稿に失敗しました。"
      @posts = Post.all
      flash[:redirect] = root_path
      redirect_to root_path
    end
      
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to public_post_path(@post), notice: "投稿に成功しました。"
    else
      render :new
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to public_posts_path
  end
  
  
  private

  def post_params
    params.require(:post).permit(:title, :body, :image)
  end
  
  
end
