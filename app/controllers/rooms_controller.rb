class RoomsController < ApplicationController
  def index
    @rooms = Room.all
    if params[:query].present?
      sql_subquery = <<~SQL
      hotels.name ILIKE :query
      OR (hotels.address ILIKE :query AND NOT hotels.address ~* '\\m\\d+\\M')
      OR rooms.price_per_night <= :query_integer
      SQL
      @rooms = Room.joins(:hotel).where(sql_subquery, query: "%#{params[:query]}%", query_integer: params[:query].to_i)
    else
      @rooms = Room.all
    end
  end

  def show
    @room = Room.find(params[:id])
    @booking = Booking.new
  end
end
