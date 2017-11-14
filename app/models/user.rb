class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Database relationships
  has_many :donations
  has_many :ngos, through: :donations

  # Validations
  validates :email, presence: true, uniqueness: true
  validates :encrypted_password, presence: true
end
