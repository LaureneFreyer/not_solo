class ReservationsController < ApplicationController
  before_action :find_reservation, only: [:edit, :update, :accept, :reject]

  def index
    @reservations = current_user.reservations
  end

  def requests
    @reservations = current_user.activities.map { |activity| activity.reservations }.flatten
  end

  def accept
    @reservation.update(status: 'Confirmée')
    redirect_to requests_path
  end

  def reject
    @reservation.update(status: 'Refusée')
    redirec_to requests_path
  end


  def create
    @reservation = Reservation.new(reservation_params)
    @reservation.user = current_user
    @reservation.status = "En attente"
    @reservation.activity = Activity.find(params[:activity_id])
    if @reservation.save!
      redirect_to reservations_path
    else
      render 'activities/show', status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if reservation_params[:status] == 'Confirmée'
      @reservation.update(status: 'Confirmée')
    elsif reservation_params[:status] == 'Refusée'
      @reservation.update(status: 'Refusée')
    end
    redirect_to requests_path
  end

  private

  def reservation_params
    params.require(:reservation).permit(:status)
  end

  def find_reservation
    @reservation = Reservation.find(params[:id])
  end
end
