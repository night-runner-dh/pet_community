class Public::GroupsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update, :destroy, :permits]

  def index
    @groups = Group.page(params[:page]).per(10)
    @user = User.find(current_user.id)
  end

  def show
    @group = Group.find(params[:id])
    @group_comments = @group.group_comments.order(created_at: :desc).page(params[:page]).per(10)
    #@group_comments = @group.group_comments.page(params[:page]).per(10)
    @group_comment = GroupComment.new
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    @group.owner_id = current_user.id
    if @group.save
      flash[:notice] = "グループを作成しました。"
      redirect_to groups_path
    else
      flash[:alert] = "グループ作成に失敗しました。"
      render :new
    end
  end

  def edit
    @group = Group.find(params[:id])
  end

  def update
    if @group.update(group_params)
      redirect_to group_path
    else
      render :edit
    end
  end
  
  def destroy
  @group = Group.find(params[:id])
    if @group.destroy
        respond_to do |format|
          format.html { redirect_to groups_path, notice: "削除に成功しました。" }
          format.js   # 追加する部分
        end
    else
        respond_to do |format|
          format.html { redirect_to groups_path(@group), alert: "削除に失敗しました。" }
          format.js   # 追加する部分
        end
    end

  end
  
  def permits
    @group = Group.find(params[:id])
    @permits = @group.permits.page(params[:page])
  end

  private

    def group_params
      params.require(:group).permit(:name, :introduction)#:group_image)
    end

    def ensure_correct_user
      @group = Group.find(params[:id])
      unless @group.owner_id == current_user.id
        redirect_to groups_path(@group), alert: "グループオーナーのみ編集が可能です"
      end
    end
end