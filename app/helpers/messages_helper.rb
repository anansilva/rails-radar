module MessagesHelper
  def self_or_other(message)
    message.sender == @receiver.class.to_s.downcase ? "other" : "self"
  end

  def message_interlocutor(message)
    message.sender == "ngo" ? message.conversation.ngo : message.conversation.user
  end
end
