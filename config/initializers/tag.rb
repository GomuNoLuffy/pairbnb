module ActsAsTaggableOn
	class Tag < ::ActiveRecord::Base
		enum category: [:amenities, :facilities, :rules]
 		
 		def create 

 		end 

	end
end



