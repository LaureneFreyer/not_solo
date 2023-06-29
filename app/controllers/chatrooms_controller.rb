class ChatroomsController < ApplicationController
  def show
    @reservation = Reservation.find(params[:id])
    @chatroom = Chatroom.find(params[:id])
    @message = Message.new
  end
end
