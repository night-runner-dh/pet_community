class Public::HomesController < ApplicationController
  def top
    #@post = Post.all.page(params[:page]).per(5)
    @post = Post.order(created_at: :desc).page(params[:page]).per(5)
  end

  def about
  end
end
