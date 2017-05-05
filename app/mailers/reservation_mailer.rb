class ReservationMailer < ApplicationMailer
  default from: "from@example.com"

  def booking_email(customer, host, reservation_id)
    @customer = customer
    @host = host
    @reservation_id = reservation_id
    @url  = "http://localhost:3000/user/#{@host.id}"
    mail(to: @host.email, subject: 'New Reservation for your Listing!')
  end

end
