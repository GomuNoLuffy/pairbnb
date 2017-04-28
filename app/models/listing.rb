class Listing < ApplicationRecord
  belongs_to :user
  acts_as_tagger

  acts_as_taggable_on :tags, :amenities, :facilities, :rules

end
