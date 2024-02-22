class BookingsController < ApplicationController

  def create
    @room = Room.find(params[:room_id]) # Assuming the room ID is available in the params
    @booking = current_user.bookings.build(booking_params.merge(room: @room))
    if @booking.save
      redirect_to room_path(params[:room_id]), notice: 'Booking was successfully created.'
    else
      flash.now[:alert] = @booking.errors.full_messages.join('. ').concat('.')
      redirect_to room_path(params[:room_id]), alert: "#{flash.now[:alert]}"
    end
  end

  def index
    @bookings = current_user.bookings
  end

  def show
    @booking = Booking.find(params[:id])
  end

  def destroy
     @booking = Booking.find(params[:id])
      @booking.destroy
      redirect_to bookings_path, notice: 'Booking was successfully canceled.'
  end


  private

  def booking_params
    params.require(:booking).permit(:starts_at, :end_at)
  end
end
