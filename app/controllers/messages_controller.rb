class MessagesController < ApplicationController
  before_action :set_message, only: [:update]

  def create
    @chatroom = Chatroom.find(params[:chatroom_id])
    @activity = Activity.find(params[:activity_id])
    @message = Message.new(message_params)
    @message.chatroom = @chatroom
    @message.user = current_user
    if @message.save
      ChatroomChannel.broadcast_to(
        @chatroom,
        message: render_to_string(partial: "message", locals: { message: @message }),
        sender_id: @message.user.id
      )
      head :ok
    else
      render "chatrooms/show", status: :unprocessable_entity
    end
  end

  def update
    @message.update!(read: true)
    render json: { status: 'ok' }
  end

  private

  def set_message
    @message = Message.find(params[:id])
  end

  def message_params
    params.require(:message).permit(:content)
  end
end
