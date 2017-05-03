class ReservationsController < ApplicationController
  def create
  	@listing = Listing.find(params[:listing_id])
    @reservation = Reservation.new(reservation_from_params)
    @reservation.user_id = current_user.id if current_user
    @reservation.listing = @listing
    
    if @reservation.save
      redirect_to current_user
    else 
      render 'listings/show'
    end
  end

  def destroy

  end

  def reservation_from_params
    params.require(:reservation).permit(:num_guests, :start_date, :end_date)
  end

end

