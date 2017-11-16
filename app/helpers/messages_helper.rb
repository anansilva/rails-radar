module MessagesHelper
  def self_or_other(sender, receiver)
    sender == receiver ? "self" : "other"
  end

  def message_interlocutor(message)
    message.sender == "ngo" ? message.conversation.ngo : message.conversation.user
  end
end
