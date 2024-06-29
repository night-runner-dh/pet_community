class Public::GroupCommentsController < ApplicationController

def create
  
group = Group.find(params[:group_id])
comment = current_user.group_comments.new(group_comment_params)
comment.group_id = params[:group_id]

if comment.save
  redirect_to group_path(group), notice: "コメントを投稿しました。"
else
  flash[:error] = comment.errors.full_messages.first
  redirect_to group_path(group), alert: "コメントの投稿に失敗しました。"
end
end

def destroy
  @group = GroupComment.find(params[:group_id])

  @group.destroy
  #PostComment.find(params[:id]).destroy
  #redirect_to public_post_path(params[:post_id])
  redirect_back(fallback_location: root_path, notice: "コメントを削除しました。")
end




private

def group_comment_params
  params.permit(:comment)
end
end