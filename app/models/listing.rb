class Listing < ApplicationRecord
  include PgSearch

  belongs_to :user
  has_many :reservations
  paginates_per 10
  acts_as_tagger

  acts_as_taggable_on :tags, :amenities, :facilities, :rules

  mount_uploaders :images, ImageUploader


  scope :country, -> (country) { where("country like ?", "#{country.titleize}%") }
  scope :guest_number, -> (guest_number) { where "guest_number >= ?", guest_number }
  scope :min_max_price, -> (min, max) { where("price > ? AND price < ?", min, max) }

  pg_search_scope :search_by_place, :against => [:country, :city], using: { tsearch: { prefix: true } }
  #You could do something like use `select_tag` with a javascript `onchange` handler, 
  #and have the handler send the value of the select dropdown as a parameter back to your app.
#scopes will always return activerecordrelation []
  # def self.search(term)
  #   where('LOWER(country) LIKE :term', term: "%#{term.downcase}%")
  # end(

  # def country_name
  #   country.try(:name)
  # end

  # def country_name=(name)
  #   self.country = Country.find_by(name: name) if name.present?
  # end
  def self.guest_numbers
    [
      ["1 guest", 1],
      ["2 guests", 2],
      ["3 guests", 3],
      ["4 guests", 4],
      ["5 guests", 5],
      ["6 guests", 6],
      ["7 guests", 7],
      ["8 guests", 8]
    ]
  end

  def self.price_range
    [
      ["RM1-100", 100], 
      ["RM101-200", 200],
      ["RM201-300", 300],
      ["RM301-400", 400],
      ["RM401-500", 500]
    ]
  end

end
