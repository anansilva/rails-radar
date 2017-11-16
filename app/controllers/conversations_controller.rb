class ConversationsController < ApplicationController
  before_action :authenticate_user!

  layout false

  def create
    if Conversation.between(params[:user_id], params[:ngo_id]).present?
      @conversation = Conversation.between(params[:user_id], params[:ngo_id])
    else
      @conversation = Conversation.create!(conversation_params)
    end

    render json: { conversation_id: @conversation.id }
  end

  def show
    @conversation = Conversation.find(params[:id])
    @receiver = interlocutor(@conversation)
    @messages = @conversation.messages
    @message = Message.new
  end

  private
    def conversation_params
      params.permit(:user_id, :ngo_id)
    end

    def interlocutor(conversation)
      if @ngo.nil?
        conversation.user
      else
        conversation.ngoe
      end
    end
end
