class ProfilesController < ApplicationController
  def show
    @user = current_user
  end

  def autres
    @user = User.find(params[:id])
  end

  def favorites
    @favorites = current_user.likes.map(&:activity)
  end
end
