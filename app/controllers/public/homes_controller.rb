class Public::HomesController < ApplicationController
  def top
  @post = Post.page(params[:page]).per(5)
  end

  def about
  end
end
