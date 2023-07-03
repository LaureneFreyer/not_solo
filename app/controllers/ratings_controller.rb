class RatingsController < ApplicationController

  def new
    @rating = Rating.new
    @user = User.find(params[:profile_id])
    if params[:act]
      @activity = Activity.find(params[:act])
    end
  end

  def create
    @user = User.find(params[:profile_id])
    @activity = Activity.find_by(id: params[:rating][:activity_id].to_i)
    @rating = Rating.new(rating_params)
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
    params.require(:rating).permit(:note, :activity_id)
  end
end
