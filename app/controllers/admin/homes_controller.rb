class Admin::HomesController < ApplicationController
  def top
    @users = User.all
    #@users = User.find(params[:id])
  end

  def about
  end
end
