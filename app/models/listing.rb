class Listing < ApplicationRecord
  belongs_to :user

  acts_as_taggable
  # acts_as_taggable_on :tag_lists

end
