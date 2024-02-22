class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :room
  validates :room_id, presence: true
  validates :starts_at, :end_at, presence: true
  validates :user_id, presence: true
  validate :check_user_booking, on: :create
  
  def check_user_booking
    if Booking.where("user_id = ? AND starts_at <= ? AND end_at >= ?", user_id, end_at, starts_at).any?
      errors.add(:base, "You already have a booking in this date")
    end
  end

end
