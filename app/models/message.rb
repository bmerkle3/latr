class Message < ApplicationRecord
  belongs_to :sender, class_name: :User
  belongs_to :receiver, class_name: :User

  # paperclip options for styles, size, default (missing image)
  has_attached_file :image
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/


    def send_sms(number, text)
    #if authenticateToken error: comment out the 'protect_from_forgery with: :exception' method in application_controller.rb
    # auth_token = ENV['TEST_TWILIO_TOKEN']
    # acct_sid = ENV['TEST_TWILIO_ID']
    auth_token = ENV['TWILIO_TOKEN']
    acct_sid = ENV['TWILIO_ID']

    @client = Twilio::REST::Client.new(acct_sid, auth_token)

    from = '+18722446988'

    message = @client.account.messages.create(
        from: from,
        to:   '+1'+ number,
        body: text.body
        )
  end

  def clean_number
    number = self.receiver.phone.scan(/\d+/).join
    number[0] == "1" ? number[0] = '' : number
    number unless number.length != 10
  end
end
