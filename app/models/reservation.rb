class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :listing
  validate :check_overlapping_dates
  validate :check_max_guests
  validate :check_num_guests
  validate :check_start_date
  enum status: [:unpaid, :paid]

  def check_overlapping_dates
  	#compare this new reservation to existing reservations
  	listing.reservations.where(status: 1).each do |prev_reserv|
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
  	if num_guests > max_guests
  	  return errors.add(:max_guests, "Maximum number of guests exceeded")
  	end 
  end

  def check_num_guests
    if num_guests <= 0
      return errors.add(:num_guests, "The number of guests must be at least 1")
    end 
  end 

  def check_start_date
  	if start_date.present? && start_date == Date.today
  	  return errors.add(:start_date, "cannot be today")
  	elsif start_date.present? && start_date < Date.today 
  	  return errors.add(:start_date, "cannot be in the past")
  	end 
  end 

  def total_price
    price = listing.price
    num_dates = (start_date..end_date).to_a.length
    return price * num_dates
  end 

end
