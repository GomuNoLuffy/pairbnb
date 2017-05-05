class BraintreeController < ApplicationController
  def new
    @client_token = Braintree::ClientToken.generate
    @reservation = Reservation.find(params[:reservation])
  end

  def checkout
  nonce_from_the_client = params[:checkout_form][:payment_method_nonce]
  price =  Reservation.find(params[:checkout_form][:reservation]).total_price.to_s
  result = Braintree::Transaction.sale(
   :amount => price, 
   :payment_method_nonce => nonce_from_the_client,
   :options => {
      :submit_for_settlement => true
    }
   )

    if result.success? #if success then create reservation #put this whole thing in reservation controller
      @reservation = Reservation.find(params[:checkout_form][:reservation])
      @user = User.find(@reservation.listing.user_id)
      ReservationMailer.booking_email(current_user, @user, @reservation.id).deliver_later
      redirect_to :root, :flash => { :success => "Transaction successful!" }
      @reservation.update_attribute(:status, 1)
    else
      redirect_to :root, :flash => { :error => "Transaction failed. Please try again." }
    end 
  end

end
