class ReservationsController < ApplicationController
  before_action :find_reservation, only: [:edit, :update, :accept_or_reject]

  def index
    @reservations = current_user.reservations
  end

  def new
    @reservation = Reservation.new
  end

  # def create
  #   @activity = Activity.find(params[:reservation][:activity_id])
  #   @reservation = @activity.reservations.create(reservation_params)

  #   if @reservation.save!
  #     flash[:notice] = "Demande de participation envoyée."
  #     @reservation.notify_host
  #     redirect_to @activity
  #   else
  #     flash[:danger] = @reservation.errors
  #   end
  # end

  # def accept_or_reject
  #   incoming = Sanitize.clean(params[:From]).gsub(/^\+\d/, '')
  #   message_input = params[:Body].downcase
  #   begin
  #     @host = User.find_by(nickname: incoming)
  #     @reservation = @host.pending_reservation

  #     if message_input == "accepter" || message_input == "Accepter"
  #       @reservation.confirm!
  #     else
  #       @reservation.reject!
  #     end

  #     @host.check_for_reservations_pending

  #     message_response = "Vous avez #{@reservation.status} la réservation."
  #     respond(message_response)
  #   rescue
  #     message_response = "Vous n'avez pas de demande de réservation."
  #     respond(message_response)
  #   end
  # end

  private

  # def respond(message)
  #   response = Twilio::TwiML::Response.new do |r|
  #     r.Message message
  #   end
  #   render text: response.text
  # end

  def reservation_params
    params.require(:reservation).permit(:status)
  end

  def find_reservation
    @reservation = Reservation.find(params[:id])
  end
end
