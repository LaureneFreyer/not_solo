class RatingsController < ApplicationController

  def create
    raise
    @rating = Rating.new(rating_params)
    @activity = Activity.find(params[:act])
    @user = User.find(params[:user_id])
    @rating.activity = @activity
    @rating.user = @user
    if @rating.save!
      redirect_to autres_path(@user), notice: 'Votre note a bien été ajoutée.'
    else
      flash[:alert] = "Une erreur est survenue lors de l'ajout de votre note."
      render :new
    end
  end

  private

  def rating_params
    params.require(:rating).permit(:note, :user_id, :activity_id)
  end
end
