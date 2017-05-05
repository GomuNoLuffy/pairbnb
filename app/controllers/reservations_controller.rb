class ReservationsController < ApplicationController
  def create
  	@listing = Listing.find(params[:listing_id])
    @reservation = Reservation.new(reservation_from_params)
    @reservation.user_id = current_user.id if current_user
    @reservation.listing = @listing
    @user = User.find(@listing.user_id)
    # @reservation.start_date = convert_to_y_m_d(params[:reservation][:start_date])
    # @reservation.end_date = convert_to_y_m_d(params[:reservation][:end_date])
    # respond_to do |format|
    if @reservation.save
      ReservationMailer.booking_email(current_user, @user, @reservation.id).deliver_now
            
      # format.html { redirect_to("/braintree/new?reservation=#{@reservation.id}", notice: 'Reservation was placed on this listing.') }
      # format.json { render json: @user, status: :created, location: @user }
      redirect_to "/braintree/new?reservation=#{@reservation.id}"
    else 
      # format.html { render action: 'new' }
      # format.json { render json: @reservation.errors.full_messages, status: :unprocessable_entity }
      @error = @reservation.errors.full_messages
      render 'listings/show'
    end
  end

  def destroy
    @reservation = Reservation.find(params[:id])
    @reservation.destroy
    redirect_to @reservation.user 
  end

  def reservation_from_params
    params.require(:reservation).permit(:num_guests, :start_date, :end_date)
  end

  # def convert_to_y_m_d(date)  
  #   new_date = date.split("/")[2] + "-" + date.split("/")[0] + "-" + date.split("/")[1]  
  #   new_date
  # end 

end

