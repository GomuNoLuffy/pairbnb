class ReservationsController < ApplicationController
  def create
  	@listing = Listing.find(params[:listing_id])
    @reservation = Reservation.new(reservation_from_params)
    @reservation.user_id = current_user.id if current_user
    @reservation.listing = @listing
    @reservation.start_date = convert_to_y_m_d(params[:reservation][:start_date])
    @reservation.end_date = convert_to_y_m_d(params[:reservation][:end_date])
    if @reservation.save
      redirect_to current_user
    else 
      @error = @reservation.errors.full_messages
      render 'listings/show'
    end
  end

  def destroy

  end

  def reservation_from_params
    params.require(:reservation).permit(:num_guests, :start_date, :end_date)
  end

  def convert_to_y_m_d(date)  
    new_date = date.split("/")[2] + "-" + date.split("/")[0] + "-" + date.split("/")[1]  
    new_date
  end 

end

