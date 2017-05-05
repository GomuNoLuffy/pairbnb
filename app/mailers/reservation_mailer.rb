class ReservationMailer < ApplicationMailer
  default from: "from@example.com"

  def booking_email(customer, host, reservation_id)
    @customer = customer
    @host = host
    @reservation_id = reservation_id
    @url  = 'http://localhost:3000/'
    mail(to: @host.email, subject: 'New Reservation for your Listing!')
  end

end
  # def booking_email(customer, user, reservation_id)
  #   @user = user
  #   @customer = Reservation.find()
  #   @url  = 'https://www.google.com/'
  #   mail(to: @user.email, subject: 'New Reservation for your Listing!')
  # end