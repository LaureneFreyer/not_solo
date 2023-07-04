class ChatroomsController < ApplicationController
  def show
    @activity = Activity.find(params[:activity_id])
    @chatroom = Chatroom.find(params[:id])
    @message = Message.new
    @chatroom.messages.where(read: false).update_all(read: true)
  end

  def members
    @chatroom = Chatroom.find(params[:activity_id])
    @activity = Activity.find(params[:chatroom_id])
    @organisateur = @activity.user
    @reservations = @activity.reservations.each { |reservation| reservation }
  end

  def mark_as_read
    @chatroom = Chatroom.find(params[:id])
    @chatroom.messages.where(read: false).update_all(read: true)
    render json: { status: 'ok' }
  end
end
