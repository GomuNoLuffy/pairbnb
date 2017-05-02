class Listing < ApplicationRecord
  belongs_to :user
  paginates_per 10
  acts_as_tagger

  acts_as_taggable_on :tags, :amenities, :facilities, :rules

  mount_uploaders :images, ImageUploader

  # def self.search(term)
  #   where('LOWER(country) LIKE :term', term: "%#{term.downcase}%")
  # end

  # def country_name
  #   country.try(:name)
  # end

  # def country_name=(name)
  #   self.country = Country.find_by(name: name) if name.present?
  # end


end
