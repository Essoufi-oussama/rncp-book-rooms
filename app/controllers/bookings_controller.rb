class BookingsController < ApplicationController

  def create
    @room = Room.find(params[:room_id]) # Assuming the room ID is available in the params
    @booking = current_user.bookings.build(booking_params.merge(room: @room))
    if @booking.save
      redirect_to room_path(params[:room_id]), notice: 'Booking was successfully created.'
    else
      redirect_to room_path(params[:room_id]), alert: "Booking was not created"
    end
  end


  private

  def booking_params
    params.require(:booking).permit(:starts_at, :end_at)
  end
end
