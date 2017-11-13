class Donation < ApplicationRecord
  belongs_to :user
  belongs_to :ngo
  belongs_to :type
end
