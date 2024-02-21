class Room < ApplicationRecord
  belongs_to :hotel
  has_many :bookings, dependent: :destroy
  
  validates :capacity, :daily_price, :hotel, presence: true
  validates :capacity, numericality: { only_integer: true, greater_than: 0 }
  validates :daily_price, numericality: { greater_than: 0 }
end
