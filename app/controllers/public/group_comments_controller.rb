class Public::GroupCommentsController < ApplicationController

def create
  
group = Group.find(params[:group_id])
comment = current_user.group_comments.new(group_comment_params)
comment.group_id = params[:group_id]

if comment.save
  redirect_to public_group_path(group), notice: "コメントを投稿しました。"
else
  flash[:error] = comment.errors.full_messages.first
  redirect_to public_group_path(group), alert: "コメントの投稿に失敗しました。"
end
  
  
  
  
  #フォームから受け取った値でチャットルームオブジェクトを取得
  #@group=Group.find(params[:group_comment][:group_id])
  #フォームから受け取った値で、チャットメッセージオブジェクトを作成
  #@group_comment=GroupComment.new(user_id: current_user.id, group_id: @group.id, content: params[:group_comment][:content])
  #保存に成功したら、フラッシュメッセージを表示し、チャットルームへリダイレクトする。
  #if @group_comment.save
    #flash[:notice]="メッセージの送信に成功しました。"
      #redirect_to public_group_path(group.id)
        #保存に失敗した場合は、フラッシュメッセージ表示し、チャットルームへリダイレクトする。
  #else
   #flash[:alert]="メッセージの送信に失敗しました。"
    #redirect_to public_group_path(group.id)
  #end
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