module ActsAsTaggableOn
	class Tag < ::ActiveRecord::Base
		enum category: [:amenities, :facilities, :rules]
	end
end



