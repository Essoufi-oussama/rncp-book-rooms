class RoomsController < ApplicationController
  def index
    @rooms = Room.all
    if params[:query].present?
      # removes all digits from the address and compares it to the query
      sql_subquery = <<~SQL
      hotels.name ILIKE :query
      OR (regexp_replace(hotels.address, '\\d', '', 'g') ILIKE :query)
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
