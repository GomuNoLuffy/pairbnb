module ActsAsTaggableOn
	class Tag < ApplicationRecord
		byebug
		enum category: [:amenities, :facilities, :rules]
	end
end

#this was not save so maybe can delete