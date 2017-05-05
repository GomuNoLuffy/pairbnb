class ReservationMailer < ApplicationMailer
  def booking_email(customer, host, reservation_id)
    @user = user
    @url  = 'http://example.com/login'
    mail(to: @user.email, subject: 'Your Reservation Details')
  end

end
