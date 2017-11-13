class Ngo < ApplicationRecord
  has_many :ngo_types
  has_many :types, through: :ngo_types
  has_many :donations
  has_many :users, through: :donations
end
