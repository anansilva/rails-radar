class Ngo < ApplicationRecord
  has_many :ngo_types
  has_many :types, through: :ngo_types
  has_many :donations
  has_many :conversations
  has_many :users, dependent: :nullify

  validates :name, presence: true
  validates :address, presence: true

  include PgSearch
  pg_search_scope :search_by_name_and_address, against: [ :name, :address ]

  geocoded_by :address
  after_validation :geocode, if: :address_changed?

end

