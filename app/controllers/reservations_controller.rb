class ReservationsController < ApplicationController
  before_action :find_reservation, only: [:edit, :update, :accept, :reject]

  def new
    @activity = Activity.find(params[:activity_id])
    @reservation = @activity.reservations.build
  end

  def create
    @activity = Activity.find(params[:activity_id])
    @reservation = @activity.reservations.build(user: current_user)
    @reservation.status = 'pending'
    if @reservation.save
      redirect_to reservations_path, notice: 'Votre demande de réservation a été soumise.'
    else
      redirect_to activity_path(@activity), alert: 'Il y a eu un problème avec votre demande de réservation.'
    end
  end


  def index
    @reservations = current_user.reservations
  end

  def requests
    @requests = Reservation.joins(:activity).where(activities: { user_id: current_user.id })
  end

  def accept
    @reservation.status = 'accepted'
    if @reservation.save
      respond_to do |format|
        format.html { redirect_to reservations_requests_path }
        format.js
      end
    else
      # handle error
    end
  end

  def reject
    @reservation.status = 'rejected'
    if @reservation.save
      respond_to do |format|
        format.html { redirect_to reservations_requests_path }
        format.js
      end
    else
      # handle error
    end
  end





  def update
    if @reservation.update(reservation_params)
      redirect_to reservations_requests_path, notice: 'Le statut de la réservation a été mis à jour.'
    else
      render :edit
    end
  end

  private

  def reservation_params
    params.require(:reservation).permit(:status)
  end

  def find_reservation
    @reservation = Reservation.find(params[:id])
  end
end
