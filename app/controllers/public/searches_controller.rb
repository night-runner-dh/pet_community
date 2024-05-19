class Public::SearchesController < ApplicationController
  before_action :authenticate_user_or_admin!
  #before_action :authenticate_user!

  def search
    @range = params[:range]
    @word = params[:word]

    if @range == "User"
      @users = User.looks(params[:search], params[:word])
    else
      @posts = Post.looks(params[:search], params[:word])
    end
  end

def authenticate_user_or_admin!
  authenticate_user! unless admin_signed_in?
end

end
