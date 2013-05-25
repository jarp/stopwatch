module Clocker

	def set (time)
		@time = time
	end

	def break_up
		@time.split(' ')
	end
	
	def hours
		break_up[0].sub('h', '').to_i
	end

	def mins
		break_up[1].sub('m', '').to_i
	end

	def to_ratio
		( (hours.to_f * 60) + (mins.to_f ) )/ 60 
	end


end