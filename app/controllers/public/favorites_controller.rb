class Public::FavoritesController < ApplicationController
  def index
    @post_favorites = current_user.favorites.order(created_at: :desc).page(params[:page]).per(5)
  end

  def create
    @post = Post.find(params[:post_id])
    @post_favorite = Favorite.new(user_id: current_user.id, post_id: params[:post_id])
    @post_favorite.save
    
  end

  def destroy
    @post = Post.find(params[:post_id])
    @post_favorite = Favorite.find_by(user_id: current_user.id, post_id: params[:post_id])
    @post_favorite.destroy
    
  end
end
