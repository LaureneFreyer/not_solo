class ChatroomsController < ApplicationController
  def show
    @reservation = Reservation.find(params[:reservation_id])
    @chatroom = Chatroom.find(params[:id])
    @message = Message.new
  end
end
