class Public::UsersController < ApplicationController
  def show
  end

  def edit
  end

  def update
  end

  def mypage
    @user = current_user
  end

  def unsubscribe
  end

  def withdraw
  end
end
