class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :listing
  validate :check_overlapping_dates
  validate :check_max_guests


  def check_overlapping_dates
  	#compare this new reservation to existing reservations
  	listing.reservations.each do |prev_reserv|
  	  if overlap?(self, prev_reserv)
  		return errors.add(:overlapping_dates, "The booking dates conflict with existing bookings")
  	  end 
  	end 
  end

  def overlap?(x,y)
  	# byebug
    (x.start_date - y.end_date) * (y.start_date - x.end_date) > 0
  end

  def check_max_guests
  	max_guests = listing.guest_number
  	return if num_guests < max_guests
  	errors.add(:max_guests, "Maximum number of guests exceeded")
  end

end
