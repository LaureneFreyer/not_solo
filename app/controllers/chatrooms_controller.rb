class ChatroomsController < ApplicationController
  def show
    @activity = Activity.find(params[:activity_id])
    @chatroom = Chatroom.find(params[:id])
    @message = Message.new
  end

  def members
    @chatroom = Chatroom.find(params[:activity_id])
    @activity = Activity.find(params[:chatroom_id])
    @organisateur = @activity.user
    @reservations = @activity.reservations.each { |reservation| reservation }
  end

end
