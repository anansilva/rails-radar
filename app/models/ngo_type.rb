class NgoType < ApplicationRecord
  belongs_to :ngo
  belongs_to :type

  validates_uniqueness_of :ngo, scope: :type
  validates_presence_of :ngo, scope: :type
end
