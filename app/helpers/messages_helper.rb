module MessagesHelper
  def self_or_other(message)
    message.sender == @sender.class.to_s.downcase ? "self" : "other"
  end

  def message_interlocutor(message)
    message.sender == "ngo" ? message.conversation.ngo : message.conversation.user
  end
end
