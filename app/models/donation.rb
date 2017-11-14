class Donation < ApplicationRecord
  belongs_to :user
  belongs_to :ngo
  belongs_to :type

  validates :items, length: { minimum: 3 }
  validates :schedule, presence: true
  validates :ngo_id, presence: true
  validates :user_id, presence: true
end
