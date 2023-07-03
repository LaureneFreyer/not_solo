class ProfilesController < ApplicationController
  def show
    @user = current_user
    @ratings = Rating.where(user: @user)
    if @ratings.size <= 1
      @sum = 0
    else
      @sum = @ratings.pluck(:note).sum / @ratings.size
    end
  end

  def autres
    @user = User.find(params[:id])
    @rating = Rating.new
    if params[:params1]
      @activity = Activity.find(params[:params1])
    end
    @ratings = Rating.where(user: @user)
    if @ratings.size <= 1
      @sum = 0
    else
      @sum = @ratings.pluck(:note).sum / @ratings.size
    end
  end

  def favorites
    @favorites = current_user.likes.map(&:activity)
  end
end
