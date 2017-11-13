class Type < ApplicationRecord
  has_many :ngo_types
  has_many :ngos, through: :ngo_types
  has_many :donations
end
