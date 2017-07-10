class MessagesController < ApplicationController
  # skip_before_filter :verify_authenticity_token
  def index
    @messages = Message.all
    render json: @messages, status: :ok
  end

  def new
    @message = Message.new
  end

  def create
    @message = Message.new(message_params)

    from_time = DateTime.now.utc
    to_time = @message.deliver_at
    dif_in_seconds = to_time - from_time
    dif_in_minutes = dif_in_seconds / 60
    dif_in_hours = dif_in_minutes / 60
    dif_in_days = dif_in_hours / 24

    if @message.save
      # *************comment in line 24 or 25 to send messages again*******
      # MessageWorker.perform_in(dif_in_minutes.minutes, @message.id)
      # MessageWorker.perform_async(@message.id)
      redirect_to root_path
    else
      redirect_to messages_new_path
    end
  end

  def show
    @message = Message.find(params[:id])
    render json: @message, status: :ok
  end

  private
  def message_params
    # removed .require(:message) for rails api on heroku
    params.require(:message).permit(:caption, :image, :sender_id, :receiver_id, :deliver_at, :deliverable)
  end
end
