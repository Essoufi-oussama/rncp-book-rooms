class Room < ApplicationRecord
  belongs_to :hotel
  has_many :bookings, dependent: :destroy
  has_one_attached :photo


  validates :capacity, :price_per_night, :hotel, presence: true
  validates :capacity, numericality: { only_integer: true, greater_than: 0 }
  validates :price_per_night, numericality: { greater_than: 0 }
end
