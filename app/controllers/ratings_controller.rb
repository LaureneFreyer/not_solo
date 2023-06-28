class RatingsController < ApplicationController

  def new
    @rating = Rating.new
    @reservation = Reservation.find(params[:reservations_id])
    @user = User.find(params[:user_id])
  end

  def create
    @rating = Rating.new(rating_params)
    @reservation = Reservation.find(params[:reservations_id])
    @rating.reservation = @reservation
    @user = User.find(params[:user_id])
    @rating.user = @user

    if @rating.save!
      redirect_to reservation_path(@reservation), notice: 'Votre note a bien été ajoutée.'
    else
      redirect_to reservation_path(@reservation), alert: 'Un problème est survenu lors de la notation.'
    end
  end

  private

  def rating_params
    params.require(:rating).permit(:note)
  end
end
