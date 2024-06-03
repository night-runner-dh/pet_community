class Public::HomesController < ApplicationController
  def top
    #@post = Post.all.page(params[:page]).per(5)
    @post = Post.order(created_at: :desc).page(params[:page]).per(5)
    @tags = Tag.unique_tags
  end

  def about
  end
end
