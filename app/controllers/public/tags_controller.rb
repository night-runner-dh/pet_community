class Public::TagsController < ApplicationController
  def index
  @tag = Tag.find_by(name: params[:name])
  @posts = Post.where('id IN (SELECT post_id FROM tags WHERE name = ?)', params[:name]).page(params[:page]).per(5)
  @tags = Tag.unique_tags
  end
end