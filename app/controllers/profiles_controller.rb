class ProfilesController < ApplicationController
  def show
    @user = current_user
  end

  def autres
    @user = User.find(params[:id])
    @rating = Rating.new
    if params[:params1]
      @activity = Activity.find(params[:params1])
    end
  end

  def favorites
    @favorites = current_user.likes.map(&:activity)
  end
end
