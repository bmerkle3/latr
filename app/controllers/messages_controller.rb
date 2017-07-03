class MessagesController < ApplicationController
  # skip_before_filter :verify_authenticity_token

  def index
    @messages = Message.all
  end

  def show
    @message = Message.find(params[:id])
  end

  def new
    @message = Message.new
  end

  def create
    @message = Message.new(message_params)
    if @message.save
      redirect_to @message, notice: 'Message was successfully created.'
    else
      render :new, status: 422
    end
  end

  private

  def message_params
    params.require(:message).permit(:text)
  end

end
