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
    p message_params
    # .strftime("%-m/%-d/%y")

    # from_time = Time.now
    p "*"*80
    p original_time = @message.deliver_at
    to_time = DateTime.parse(@message.deliver_at.to_s)
    # @send_in = helpers.distance_of_time_in_words(from_time, to_time)
    # @message.deliver_at = to_time

    if @message.save
      # MessageWorker.perform_in(5.minutes, @message.id)
      MessageWorker.perform_async(@message.id)
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
