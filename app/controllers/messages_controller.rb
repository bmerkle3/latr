class MessagesController < ApplicationController
  # skip_before_filter :verify_authenticity_token

  def new
    @message = Message.new
  end



  def send_message
    @message = Message.new(message_params)
    from_time = Time.now
    to_time = DateTime.parse(@message.send_at.to_s)
    @send_in = helpers.distance_of_time_in_words(from_time, to_time)
    @message.send_at = to_time

    if @message.save
      # MessageWorker.perform_in(5.minutes, @message.id)
      MessageWorker.perform_async(@message.id)
      redirect_to root_path
    else
      redirect_to messages_new_path
    end
  end

  private

  def message_params
    params.require(:message).permit(:caption, :image_url, :sender_id, :receiver_id, :deliver_at, :deliverable)
  end

end
