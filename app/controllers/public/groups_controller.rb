class Public::GroupsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update, :destroy, :permits]

  def index
    @groups = Group.page(params[:page]).per(10)
    @user = User.find(current_user.id)
  end

  def show
    @group = Group.find(params[:id])
    @group_comments = @group.group_comments.page(params[:page]).per(10)
    @group_comment = GroupComment.new
    
    #@group = Group.find(params[:id])
    #@group_comments = GroupComment.new
    #@group_comment = @group.group_comments.page(params[:page]).per(10)
    #GroupComment.page(params[:page])
    #@group.group_comments.paginate(page: params[:page], per_page: 10)
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    @group.owner_id = current_user.id
    if @group.save
      redirect_to public_groups_path
    else
      render :new
    end
  end

  def edit
    @group = Group.find(params[:id])
  end

  def update
    if @group.update(group_params)
      redirect_to public_group_path
    else
      render :edit
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
        redirect_to public_groups_path(@group), alert: "グループオーナーのみ編集が可能です"
      end
    end
end