class ListingsController < ApplicationController

  def index
  	# @listings = current_user.listings
  	# flash[:error] = "You don't have any listings!" if @listings == []
   if params[:tag]
     @listings = Listing.tagged_with(params[:tag]).order(:name).page params[:page]

   elsif params[:term]
      if params[:term].present?
        @listings = Listing.where(nil) # creates an anonymous scope
        @listings = @listings.search_by_place(params[:term]).guest_number(params["guest_number"].to_i).min_max_price((params["price"].to_i)-99, params["price"].to_i).order(:name).page params[:page]
      elsif params[:term].blank?
        @listings = Listing.where(nil)
        @listings = @listings.guest_number(params["guest_number"].to_i).min_max_price((params["price"].to_i)-99, params["price"].to_i).order(:name).page params[:page]
      end 
     # search_term = params[:term].titleize
     # @listings = Listing.where('country LIKE ?', "%#{search_term}%").order(:name).page params[:page]
        respond_to do |format|
          format.js
        end

    elsif signed_in?
       @listings = current_user.listings.order(:name).page params[:page] #can i put this under user??
       flash[:error] = "You don't have any listings!" if @listings == []
   end
end

#   def search
#     respond_to do |format|
#       format.html
#       format.json { @listings = Listing.search(params[:term]) }
#     end
# end


  def new
    @listing = Listing.new  #initialize an empty object for the form, so that we can fill in with details using the form.
    render template: "listings/new"
  end

  def create
   @listing = Listing.new(listing_from_params)
   @listing.user_id = current_user.id if current_user
     if @listing.save
       redirect_to @listing
     else
        render 'new'
     end
  end

  def show
    @listing = Listing.find(params[:id])
    @reservation = @listing.reservations.new
  end

  def edit
    @listing = Listing.find(params[:id])
  end 

  def update
    @listing = Listing.find(params[:id])
    @listing.update(listing_from_params)
    redirect_to @listing
  end 


  def listing_from_params
    params.require(:listing).permit(:name, :place_type, :property_type, :room_number, :bed_number, :guest_number, :country, :state, :city, :zipcode, :address, :price, :description, amenity_list:[], facility_list:[], rule_list:[], images:[])
  end


end
