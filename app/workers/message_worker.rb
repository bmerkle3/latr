class MessageWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(message_id)
    @message = Message.find(message_id)
    puts "SIDEKIQ WORKER SENDING A MESSAGE TO #{@message.receiver.phone}"
    @message.send_sms(@message.clean_number, @message)
  end
end
