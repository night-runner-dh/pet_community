class Public::PostCommentsController < ApplicationController

def create
  post = Post.find(params[:post_id])
  comment = current_user.post_comments.new(post_comment_params)
  comment.post_id = params[:post_id]
  
  if comment.save
    redirect_to public_post_path(post)
  else
    flash[:error] = comment.errors.full_messages.first
    @post = Post.find(params[:post_id]) # 修正点: 再度@postを取得する
    @comments = @post.post_comments.page(params[:page]) # 修正点: @commentsを再度設定する
    render template: 'public/posts/show', id: @post.id # 修正点: @post.idを渡す
  end
end


def destroy
  @post = PostComment.find(params[:post_id])

  @post.destroy
  #PostComment.find(params[:id]).destroy
  #redirect_to public_post_path(params[:post_id])
  redirect_back(fallback_location: root_path)
end

private

def post_comment_params
  params.permit(:comment)
end

end
