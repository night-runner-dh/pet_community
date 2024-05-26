class Admin::GroupsController < ApplicationController

def destroy
  @group = group.find(params[:id])
    if @group.destroy
        respond_to do |format|
          format.html { redirect_to public_groups_path, notice: "削除に成功しました。" }
          format.js   # 追加する部分
        end
    else
        respond_to do |format|
          format.html { redirect_to public_groups_path(@post), alert: "削除に失敗しました。" }
          format.js   # 追加する部分
        end
    end
end
end
