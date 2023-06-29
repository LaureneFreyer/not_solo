class ChatroomsController < ApplicationController
  def show
    @activity = Activity.find(params[:activity_id])
    @chatroom = Chatroom.find(params[:id])
    @message = Message.new
  end
end
