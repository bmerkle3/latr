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
    dif_time = to_time - from_time
    dif_days = dif_time / 60 / 60 / 24
    dif_days

    if @message.save
      MessageWorker.perform_in(dif_days.days, @message.id)
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
    params.permit(:caption, :image, :sender_id, :receiver_id, :deliver_at, :deliverable)
  end
end
