class Admin::GroupsController < ApplicationController

def show
    @group = Group.find(params[:id])
    @group_comment = @group.group_comments.page(params[:page]).per(10)
end

def index
  @groups = Group.all
end

def destroy
  @group = Group.find(params[:id])
    if @group.destroy
        respond_to do |format|
          format.html { redirect_to admin_groups_path, notice: "削除に成功しました。" }
          format.js   # 追加する部分
        end
    else
        respond_to do |format|
          format.html { redirect_to admin_groups_path(@post), alert: "削除に失敗しました。" }
          format.js   # 追加する部分
        end
    end
end
end
