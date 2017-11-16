class Conversation < ApplicationRecord
  belongs_to :user
  belongs_to :ngo

  has_many :messages, dependent: :destroy

  validates_uniqueness_of :user_id, scope: :ngo_id

  # This was in the documentation. Doesn't make a lot of sense right now
  # with different user models (ngo and user)

  scope :involving, -> (user) do
    where("conversations.user_id =?", user.id)
  end

  scope :involving, -> (ngo) do
    where("conversations.ngo_id =?", ngo.id)
  end

  scope :between, -> (user, ngo) do
    where("(conversations.user_id = ? AND conversations.ngo_id =?)", user, ngo)
  end
end
